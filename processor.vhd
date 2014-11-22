library ieee;
use ieee.std_logic_1164.all;

entity processor is   
port
(
	clk: std_logic
	);
end processor;

architecture strcut of processor is

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

signal incremented_PC: std_logic_vector(31 downto 0);
signal branched_PC: std_logic_vector(31 downto 0);
signal muxed_PC: std_logic_vector(31 downto 0);

begin

d1 : decoder port map (stuff_goes_here);
r1: register_file port map (regA,regB, muxedRegWrite, writeEnable,selA,selB,writeRegSel);
m1: mux_32 port map (sel<= ALUMuxControl, src0<=regB, src1<=sign_extended_immediate, z<=muxed_ALU_B); -- alu imput b
a1: ALU port map (waiting_on_hannah_for_things);
or1: or_gate port map (MemRead, MemWrite, memActive);
mem1: syncram port map (clk, memActive, MemRead, MemWrite, storeLoc, writeWord, readWord);
m2: mux_32 port map (write_Mux_Control, ALU_out, readWord, muxedRegWrite); -- Write mux
m3: mux_32 port map (branch_logic, incremented_PC, branched_PC, muxed_PC)
a1: ADDER port  map ()
a2: ADDER port map ()



end architecture ; -- strcut