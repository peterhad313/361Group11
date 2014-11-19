library ieee;
use ieee.std_logic_1164.all;


entity demo_reg is
   port (
  outA          : out std_logic_vector(31 downto 0);
  outB          : out std_logic_vector(31 downto 0)
  );
end demo_reg;

architecture structural of demo_reg is   
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
  constant half_period : time := 20 ns;

  signal input         : std_logic_vector(31 downto 0);
  signal writeEnable   : std_logic;
  signal regASel       : std_logic_vector(4 downto 0);
  signal regBSel       : std_logic_vector(4 downto 0);
  signal writeRegSel   : std_logic_vector(4 downto 0);
  signal clk : std_logic := '0';
  begin
    clk <= not clk after half_period;
    x1 : register_file port map (outA, outB, input, writeEnable,regASel,regBSel,writeRegSel,clk);
      test_proc : process    begin
      --test write --
      input<="00000000000000000000000000000001";
      writeEnable<='1';
      regBSel<="00000";
      regASel<="00000";
      writeRegSel<="00001";
      wait for 40 ns;
      input<="00000000000000000000000000000010";
      writeRegSel<="00010";
      wait for 40 ns;
      input<="00000000000000000000000000000011";
      writeRegSel<="00011";
      regBSel<="00010";
      regASel<="00001";
      wait for 40 ns;
      wait;
      
    end process;
  end architecture structural;



