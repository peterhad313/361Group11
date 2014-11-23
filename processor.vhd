library ieee;
use ieee.std_logic_1164.all;

entity processor is   
port
(
	clk: in std_logic
	);
end processor;

architecture struct of processor is

component opcode_splitter is   
port
(
	op_code_in: in std_logic_vector(31 downto 0);
	regA_sel: out std_logic_vector(4 downto 0);
	regB_sel: out std_logic_vector(4 downto 0);
	regC_sel: out std_logic_vector(4 downto 0);
	op_code_out: out std_logic_vector (5 downto 0);
	func: out std_logic_vector( 5 downto 0);
	jmp_addr: out std_logic_vector(25 downto 0);
	immediate: out std_logic_vector(31 downto 0);
	shamt: out std_logic_vector(31 downto 0)
	);
end component;
  
  
component register_file is   
port
(
	outA          : out std_logic_vector(31 downto 0);
	outB          : out std_logic_vector(31 downto 0);
	input         : in  std_logic_vector(31 downto 0);
	writeEnable   : in std_logic;
	regASel       : in std_logic_vector(4 downto 0);
	regBSel       : in std_logic_vector(4 downto 0);
	writeRegSel   : in std_logic_vector(4 downto 0);
	clock         : in std_logic
	);
end component;

component syncram is
generic (
	mem_file : string
	);
port (
	clk   : in  std_logic;
	cs	  : in	std_logic;
	oe	  :	in	std_logic;
	we	  :	in	std_logic;
	addr  : in	std_logic_vector(31 downto 0);
	din	  :	in	std_logic_vector(31 downto 0);
	dout  :	out std_logic_vector(31 downto 0)
	);
end component;

component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

component or_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component alu_32 is
	port (
		ctrl	: in std_logic_vector(3 downto 0);	-- 
		A		: in std_logic_vector(31 downto 0);
		B		: in std_logic_vector(31 downto 0);
		cout	: out std_logic;	-- '1' -> carry out
		ovf		: out std_logic;	-- '1' -> overflow
		ze		: out std_logic;	-- '1' -> is zero
		R		: out std_logic_vector(31 downto 0) -- result
	);
end component;

component adder_32 is
	port (
		A,B	: in std_logic_vector(31 downto 0);
		sum	: out std_logic_vector(31 downto 0);
		cout: out std_logic
	);
end component;

component ddf_32 is 
  port(
    clock : in std_logic;
    input : in std_logic_vector(31 downto 0);
    output: out std_logic_vector(31 downto 0)
  );
end component;

component control is
  port (
    opcode   : in  std_logic_vector(5 downto 0); --opcode in is 6 bit input
	func : in std_logic_vector(5 downto 0);
    rw   : out std_logic; --register write
	mux_ALU   : out std_logic; --the pre-ALU mux control
	mux_write  : out std_logic; --the pre-register write mux control
	br   : out std_logic; --branch
	eq   : out std_logic; --branch equal
	memrd  : out std_logic; --memory read
	memwr  : out std_logic; --memory write
	alu   : out std_logic_vector(3 downto 0) --ALU control
  );
end component;

--Signals
signal regA : std_logic_vector(31 downto 0);
signal regB : std_logic_vector(31 downto 0);
signal muxedRegWrite: std_logic_vector(31 downto 0);
signal selA: std_logic_vector(4 downto 0);
signal selB: std_logic_vector(4 downto 0);
signal writeRegSel: std_logic_vector(4 downto 0);
signal muxed_ALU_B: std_logic_vector(31 downto 0);
signal ALU_out: std_logic_vector(31 downto 0);
signal opcode: std_logic_vector(5 downto 0);
signal func: std_logic_vector( 5 downto 0);
signal jmp_addr:  std_logic_vector(25 downto 0);
signal immediate:  std_logic_vector(31 downto 0);
signal shamt:  std_logic_vector(31 downto 0);
signal cout,ovf,ze: std_logic;
signal add_cout: std_logic;
signal instruction: std_logic_vector(31 downto 0);
signal InstRead, InstWrite: std_logic;
signal memActive: std_logic;

signal incremented_PC: std_logic_vector(31 downto 0);
signal branched_PC: std_logic_vector(31 downto 0);
signal muxed_PC: std_logic_vector(31 downto 0);
signal PC_out: std_logic_vector(31 downto 0);
signal readWord: std_logic_vector(31 downto 0);

--Control signals
signal rw : std_logic; --register write
signal mux_ALU : std_logic; --the pre-ALU mux control
signal mux_write : std_logic; --the pre-register write mux control
signal br : std_logic; --branch
signal eq  : std_logic; --branch equal
signal memrd : std_logic; --memory read
signal memwr  : std_logic; --memory write
signal alu   : std_logic_vector(3 downto 0); --ALU control

begin

opcode1: opcode_splitter port map (instruction, selA, selB, writeRegSel, opcode, func, jmp_addr, immediate, shamt);
control_unit: control port map (opcode, func, rw, mux_ALU, mux_write, br, eq, memrd, memwr, alu);
r1: register_file port map (regA,regB, muxedRegWrite, memwr,selA,selB,writeRegSel,clk);
m1: mux_32 port map (mux_ALU, regB, immediate,muxed_ALU_B); -- alu input b
alu1: alu_32 port map (alu, regA, muxed_ALU_B, cout, ovf, ze, ALU_out);
or1: or_gate port map (memrd, memwr, memActive);
mem1: syncram 
	generic map (mem_file=>"bills_branch.dat")
	port map (clk, memActive, memrd, memwr, ALU_out, regB, readWord); --Data memory
mem2: syncram 
	generic map (mem_file=>"bills_branch.dat")
	port map (clk, '1', '1', '0', PC_out, x"00000000", instruction); --Instruction memory
m2: mux_32 port map (mux_write, ALU_out, readWord, muxedRegWrite); -- Write mux
m3: mux_32 port map (br, incremented_PC, branched_PC, muxed_PC);
a1: adder_32 port  map (PC_out, x"00000004", incremented_PC, add_cout);
a2: adder_32 port map (instruction, incremented_PC, branched_PC, add_cout);
pc: ddf_32 port map (clk, muxed_PC, PC_out);


end architecture ; -- strcut