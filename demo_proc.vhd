library ieee;
use ieee.std_logic_1164.all;


entity demo_proc is
port (
  outA: out std_logic
  );
end demo_proc;

architecture structural of demo_proc is   
signal clk : std_logic := '0';
signal reset: std_logic;
constant half_period : time := 5 ns;

component processor is   
port
(
  clk: in std_logic;
  reset: in std_logic
  );
end component;

begin
outA<='1';
clk <= not clk after half_period;
x1 : processor port map (clk,reset);
test_proc : process begin
      --test write --
      reset<='1';
      wait for 40 ns;
      reset<='0';
      wait;
      
      end process;

      end architecture structural;