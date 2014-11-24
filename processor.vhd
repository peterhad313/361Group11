library ieee;
use ieee.std_logic_1164.all;

entity processor is   
port
(
	clk: in std_logic;
	reset: in std_logic
	);
end processor;

architecture struct of processor is

--Splits instruction into useful components
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
  
--Register file  
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

--Memory
component sram is
generic (
	mem_file : string
	);
port (
	--clk   : in  std_logic;
	cs	  : in	std_logic;
	oe	  :	in	std_logic;
	we	  :	in	std_logic;
	addr  : in	std_logic_vector(31 downto 0);
	din	  :	in	std_logic_vector(31 downto 0);
	dout  :	out std_logic_vector(31 downto 0)
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


--32 bit Mux
component mux_32 is
  port (
	sel   : in  std_logic;
	src0  : in  std_logic_vector(31 downto 0);
	src1  : in  std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

--Or gate
component or_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

--ALU
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

--32 bit adder
component adder_32 is
	port (
		A,B	: in std_logic_vector(31 downto 0);
		sum	: out std_logic_vector(31 downto 0);
		cout: out std_logic
	);
end component;

--32 bit D Flip-Flop
component ddf_32 is 
  port(
    clock : in std_logic;
    input : in std_logic_vector(31 downto 0);
    output: out std_logic_vector(31 downto 0)
  );
end component;

--Control unit
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

component nand_gate is
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component and_gate is
port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component mux_5 is
	port (
		sel : in std_logic;
		src0: in std_logic_vector(4 downto 0);
		src1: in std_logic_vector(4 downto 0);
		z	: out std_logic_vector(4 downto 0)
	);
end component;

component nor_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component xnor_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

--*************************************************
--Signals
--*************************************************
--PC Signals
signal muxed_PC: std_logic_vector(31 downto 0); --Input to PC flip-flop
signal PC_in, PC_out: std_logic_vector(31 downto 0); --Next PC
signal incremented_PC: std_logic_vector(31 downto 0); --Incremented PC
signal branched_PC: std_logic_vector(31 downto 0); --Branched PC
--Instruction signals
signal instruction: std_logic_vector(31 downto 0); --Instruction, output of instruction memory
signal selA: std_logic_vector(4 downto 0);
signal selB: std_logic_vector(4 downto 0);
signal rd: std_logic_vector (4 downto 0);
signal writeRegSel: std_logic_vector(4 downto 0);
signal opcode: std_logic_vector(5 downto 0); --Opcode from instruction
signal func: std_logic_vector( 5 downto 0); --Function from instruction
signal jmp_addr:  std_logic_vector(25 downto 0); --Jump address from instruction
signal immediate:  std_logic_vector(31 downto 0); --Add or subtract immediate
signal shamt:  std_logic_vector(31 downto 0); --Shift amount
--Control signals
signal rw : std_logic; --register write
signal mux_ALU : std_logic; --the pre-ALU mux control
signal mux_write : std_logic; --the pre-register write mux control
signal br : std_logic; --branch
signal eq  : std_logic; --branch equal
signal memrd : std_logic; --memory read
signal memwr  : std_logic; --memory write
signal alu   : std_logic_vector(3 downto 0); --ALU control
signal memActive: std_logic;
--Register file signals
signal regA : std_logic_vector(31 downto 0);
signal regB : std_logic_vector(31 downto 0);
signal muxedRegWrite: std_logic_vector(31 downto 0); --Data input to register file
--ALU Signals
signal muxed_ALU_B: std_logic_vector(31 downto 0); --ALU input B
signal ALU_out: std_logic_vector(31 downto 0); --ALU output
signal cout,ovf,ze: std_logic;
--Adder signal
signal add_cout: std_logic;
--Data signals
signal InstRead, InstWrite: std_logic;
signal readWord: std_logic_vector(31 downto 0);
signal nandTemps: std_logic_vector(3 downto 0);
signal rTypeInstruction: std_logic;
signal shiftLogic: std_logic;
signal double_muxed_ALU_B: std_logic_vector(31 downto 0);
signal shiftTemp: std_logic;
signal branch_temp: std_logic;
signal branch_mux_signal: std_logic;


begin
--PC unit
m1: mux_32 port map (reset, muxed_PC, x"00400020", PC_in);
pc: ddf_32 port map (clk, PC_in, PC_out);
--Instruction memory
mem1: syncram 
	generic map ("bills_branch.dat")
	port map (clk, '1', '1', '0', PC_out, x"00000000", instruction); --Instruction memory
--Logic to increment PC
xnor1: xnor_gate port map (ze,eq, branch_temp);
and2: and_gate port map (branch_temp, br, branch_mux_signal);
m2: mux_32 port map (br, incremented_PC, branched_PC, muxed_PC);
a1: adder_32 port  map (PC_out, x"00000004", incremented_PC, add_cout);
a2: adder_32 port map (instruction, incremented_PC, branched_PC, add_cout);
--Instruction splitter
inst1: opcode_splitter port map (instruction, selA, selB, rd, opcode, func, jmp_addr, immediate, shamt);
nand1: nand_gate port map (opcode(5),opcode(4),nandTemps(3));
nand2: nand_gate port map (opcode(3), opcode (2), nandTemps(2));
nand3: nand_gate port map (opcode(1), opcode(0), nandTemps(1));
nand4: nand_gate port map (nandTemps(3), nandTemps(2), nandTemps(0));
nand5: nand_gate port map (nandTemps(1), nandTemps(0),rTypeInstruction);
m5: mux_5 port map (rTypeInstruction, rd, selB, writeRegSel);
--Control unit
control_unit: control port map (opcode, func, rw, mux_ALU, mux_write, br, eq, memrd, memwr, alu);
or1: or_gate port map (memrd, memwr, memActive);
--Register file
r1: register_file port map (regA,regB, muxedRegWrite, rw,selA,selB,writeRegSel,clk);
--Mux into ALU
m3: mux_32 port map (mux_ALU, regB, immediate,muxed_ALU_B); -- alu input b
nor1: nor_gate port map (opcode(5),opcode(3), shiftTemp);
and1: and_gate port map (shiftTemp, mux_ALU, shiftLogic);
m6: mux_32 port map (shiftLogic, muxed_ALU_B, shamt, double_muxed_ALU_B);
alu1: alu_32 port map (alu, regA, double_muxed_ALU_B, cout, ovf, ze, ALU_out);
--Data memory
mem2: sram 
	generic map ("bills_branch.dat")
	port map (memActive, memrd, memwr, ALU_out, regB, readWord); --Data memory
--Mux to select data
m4: mux_32 port map (mux_write, readWord, ALU_out, muxedRegWrite); -- Write mux


end architecture ; -- struct