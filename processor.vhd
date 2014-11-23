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
end alu_32;

component adder_32 is
	port (
		A,B	: in std_logic_vector(31 downto 0);
		sum	: out std_logic_vector(31 downto 0);
		cout: out std_logic
	);
end adder_32;

component ddf_32 is 
  port(
    clock : in std_logic;
    input : in std_logic_vector(31 downto 0);
    output: out std_logic_vector(31 downto 0)
  );
end ddf_32;


signal regA : std_logic_vector(31 downto 0);
signal regB : std_logic_vector(31 downto 0);
signal muxedRegWrite: std_logic_vector(31 downto 0);
signal writeEnable : std_logic;
signal selA: std_logic_vector(4 downto 0);
signal selB: std_logic_vector(4 downto 0);
signal writeRegSel: std_logic_vector(4 downto 0);
signal ALUMuxControl: std_logic;
signal muxed_ALU_B: std_logic_vector(31 downto 0);
signal ALU_out: std_logic_vector(31 downto 0);
signal write_Mux_Control: std_logic;
signal opcode: std_logic_vector(31 downto 0);
signal func: std_logic_vector( 5 downto 0);
signal jmp_addr:  std_logic_vector(25 downto 0);
signal immediate:  std_logic_vector(31 downto 0);
signal shamt:  std_logic_vector(31 downto 0);
signal cout,ovf,ze: std_logic;
signal add_cout: std_logic;
signal instruction: std_logic_vector(31 downto 0);
signal InstRead, InstWrite: std_logic;

signal incremented_PC: std_logic_vector(31 downto 0);
signal branched_PC: std_logic_vector(31 downto 0);
signal muxed_PC: std_logic_vector(31 downto 0);
signal PC_out: std_logic_vector(31 downto 0);

begin

opcode1: opcode_splitter port map (instruction, selA, selB, writeRegSel, opcode, func, jmp_addr, immediate, shamt);
r1: register_file port map (regA,regB, muxedRegWrite, writeEnable,selA,selB,writeRegSel);
m1: mux_32 port map (ALUMuxControl, regB, immediate,muxed_ALU_B); -- alu input b
a1: ALU port map (CONTROL, regA, muxed_ALU_B, cout, ovf, ze, ALU_out);
or1: or_gate port map (MemRead, MemWrite, memActive);
mem1: syncram 
	generic map (bills_branch.dat);
	port map (clk, memActive, MemRead, MemWrite, storeLoc, writeWord, readWord); --Data memory
mem2: syncram 
	generic map (bills_branch.dat);
	port map (clk, '1', '1', '0', PC_out, x"000000000", instruction); --Instruction memory
m2: mux_32 port map (write_Mux_Control, ALU_out, readWord, muxedRegWrite); -- Write mux
m3: mux_32 port map (branch_logic, incremented_PC, branched_PC, muxed_PC);
a1: adder_32 port  map (PC_out, x"00000004", incremented_PC, add_cout);
a2: adder_32 port map (MEMORY, incremented_PC, branched_PC, add_cout);
pc: ddf_32 port map (clk, muxed_PC, PC_out);


end architecture ; -- strcut