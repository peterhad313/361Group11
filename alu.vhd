library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port (
    ctrl  : in std_logic_vector(3 downto 0);
    A     : in std_logic_vector(31 downto 0);
    B     : in std_logic_vector(31 downto 0);
    cout  : out std_logic;  -- ?1? -> carry out
    ovf   : out std_logic;  -- ?1? -> overflow
    ze    : out std_logic;  -- ?1? -> is zero
    R     : out std_logic_vector(31 downto 0) -- result
  );
end alu;

architecture structural of alu is
  
  
component adder_32 is
  port (
    cin   : in std_logic;
    x     : in std_logic_vector(31 downto 0);
    y     : in std_logic_vector(31 downto 0);
    cout  : out std_logic;
    z     : out std_logic_vector(31 downto 0);
    ovf   : out std_logic;
    less  : out std_logic
  );
end component;

component or_gate_32 is
  port (
    x   : in  std_logic_vector(31 downto 0);
    y   : in  std_logic_vector(31 downto 0);
    z   : out std_logic_vector(31 downto 0)
  );
end component;
  
component and_gate_32 is
  port (
    x   : in  std_logic_vector(31 downto 0);
    y   : in  std_logic_vector(31 downto 0);
    z   : out std_logic_vector(31 downto 0)
  );
end component;

component mux_4input is
  port (
	sel	  : in	std_logic_vector(3 downto 0);
	src0  : in	std_logic_vector(31 downto 0);
	src1  :	in	std_logic_vector(31 downto 0);
	src2  :	in	std_logic_vector(31 downto 0);
	src3  :	in	std_logic_vector(31 downto 0);
	z	    : out std_logic_vector(31 downto 0)
  );
end component;

component not_gate_32 is
  port (
    x   : in  std_logic_vector(31 downto 0);
    z   : out std_logic_vector(31 downto 0)
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

component sll_32 is
  port (
    x   : in  std_logic_vector(31 downto 0);
    y   : in  std_logic_vector(31 downto 0);  -- only bottom five will be used --
    z   : out std_logic_vector(31 downto 0)
  );
end component;

component sltu is
  port (
    less   : in  std_logic;
    a32   : in  std_logic;
    b32   : in  std_logic;
    z   : out std_logic
  );
end component;

component zeCheck is
  port (
    input   : in  std_logic_vector(31 downto 0);
    ze   : out std_logic
  );
end component;

component and_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

component xor_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
  );
end component;

signal Binvert : std_logic_vector(31 downto 0); --will hold the conditionally inverted B
signal theChosenB : std_logic_vector(31 downto 0);
signal addTemp : std_logic_vector(31 downto 0); -- hold result of add, or subtract
signal sltTemp : std_logic_vector(31 downto 0);
signal sltuTemp : std_logic_vector(31 downto 0);
signal andTemp : std_logic_vector(31 downto 0);
signal orTemp  : std_logic_vector(31 downto 0);
signal sllTemp : std_logic_vector(31 downto 0);
signal muxedAdder : std_logic_vector(31 downto 0);
signal muxedSlts : std_logic_vector(31 downto 0);
signal less : std_logic;
signal sltu31 : std_logic;
signal beforeZeCheck: std_logic_vector(31 downto 0);
signal shiftMuxTemp : std_logic;
signal shiftMux : std_logic;
begin
  
  inv1: not_gate_32 port map (B, Binvert);
  mux1: mux_32 port map (ctrl(2),B, Binvert,theChosenB); 
  add1: adder_32 port map (ctrl(2), A, theChosenB, cout, addTemp, ovf, less);
  stlu1: sltu port map (less, A(31),B(31), sltu31);
  sltTemp <= "0000000000000000000000000000000" & less;
  sltuTemp <= "0000000000000000000000000000000" & sltu31;
  mux2: mux_32 port map (ctrl(3), sltTemp, sltuTemp, muxedSlts);
  and1: and_gate_32 port map (A,B, andTemp);
  or1: or_gate_32 port map (A,B, orTemp);
  mux_41: mux_4input port map (ctrl, andTemp, orTemp, addTemp, muxedSlts,muxedAdder);
  sll1: sll_32 port map (A, B, sllTemp);
  xor2: xor_gate port map (ctrl(3), ctrl(1), shiftMuxTemp);
  and2: and_gate port map (ctrl(3), shiftMuxTemp, shiftMux);
  mux3: mux_32 port map (shiftMux,muxedAdder,sllTemp,beforeZeCheck);
  ze1: zeCheck port map (beforeZeCheck,ze);
  R <= beforeZeCheck;
  
end structural;
