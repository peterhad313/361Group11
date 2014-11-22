library ieee;
use ieee.std_logic_1164.all;
use work.bit_alu;

entity alu_32_tb is
end alu_32_tb;

architecture behavioral of alu_32_tb is
signal ctrl	: std_logic_vector(3 downto 0);	-- 
signal A	: std_logic_vector(31 downto 0);
signal B	: std_logic_vector(31 downto 0);
signal cout	: std_logic;	-- '1' -> carry out
signal ovf	: std_logic;	-- '1' -> overflow
signal ze	: std_logic;	-- '1' -> is zero
signal R	: std_logic_vector(31 downto 0); -- result
begin
  test: entity work.alu_32
    port map (
      ctrl=>ctrl,
      A=>A,
      B=>B,
      cout=>cout,
	  ovf=>ovf,
	  ze=>ze,
	  R=>R);
  testbench : process
  begin
    ctrl <= "0000";
	A <= "00000000000000000000000000000101";
	B <= "10000000000000000000000000001010";
    wait for 10 ns;
	ctrl <= "0001";
    A <= "00000000000000000000000000000101";
	B <= "10000000000000000000000000001010";
    wait for 10 ns;
	ctrl <= "0010";
    A <= "00000000000000000000000000000101";
	B <= "10000000000000000000000000001010";
    wait for 10 ns;
	ctrl <= "0011";
    A <= "00000000000000000000000000000101";
	B <= "10000000000000000000000000001010";
    wait for 10 ns;
	ctrl <= "0100";
    A <= "00000000000000000000000000000101";
	B <= "10000000000000000000000000001010";
    wait for 10 ns;
	ctrl <= "0101";
    A <= "00000000000000000000000000000101";
	B <= "10000000000000000000000000001010";
    wait for 10 ns;
	ctrl <= "0110";
    A <= "00000000000000000000000000000101";
	B <= "10000000000000000000000000001010";
    wait for 10 ns;
    wait;
  end process;
end behavioral;
