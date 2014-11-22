library ieee;
use ieee.std_logic_1164.all;
use work.bit_alu;

entity bit_alu_tb is
end bit_alu_tb;

architecture behavioral of bit_alu_tb is
signal ctrl	: std_logic_vector(6 downto 0);
signal A	: std_logic;
signal B	: std_logic;
signal cin_add	: std_logic;
signal cin_sub	: std_logic;
signal cin_sll	: std_logic;	
signal z_in	: std_logic;	
signal add_cout: std_logic;
signal sub_cout: std_logic;
signal sll_cout: std_logic;
signal z_out	: std_logic;
signal slt_out	: std_logic;
signal R		: std_logic;
begin
  test: entity work.bit_alu
    port map (
      ctrl=>ctrl,
      A=>A,
      B=>B,
      cin_add=>cin_add,
      cin_sub=>cin_sub,
	  cin_sll=>cin_sll,
	z_in=>z_in,
	  add_cout=>add_cout,
	  sub_cout=>sub_cout,
	  sll_cout=>sll_cout,
	z_out=>z_out,
	  slt_out=>slt_out,
	  R=>R);
  testbench : process
  begin
    ctrl <= "0000001";
    A <= '1';
	B <= '1';
	cin_add <= '0';
	cin_sub <= '0';
	cin_sll <= '0';
    wait for 10 ns;
	ctrl <= "0000010";
    A <= '1';
	B <= '1';
	cin_add <= '0';
	cin_sub <= '0';
	cin_sll <= '0';
    wait for 10 ns;
	ctrl <= "0000100";
    A <= '1';
	B <= '1';
	cin_add <= '0';
	cin_sub <= '0';
	cin_sll <= '0';
    wait for 10 ns;
	ctrl <= "0001000";
    A <= '1';
	B <= '1';
	cin_add <= '0';
	cin_sub <= '1';
	cin_sll <= '0';
    wait for 10 ns;
	ctrl <= "0010000";
    A <= '1';
	B <= '1';
	cin_add <= '0';
	cin_sub <= '0';
	cin_sll <= '0';
    wait for 10 ns;
    wait;
  end process;
end behavioral;
