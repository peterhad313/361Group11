library ieee;
use ieee.std_logic_1164.all;


entity opcode_splitter is   
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
end opcode_splitter;

architecture struct of opcode_splitter is

begin
op_code_out <= op_code_in(31 downto 26);
regA_sel<= op_code_in(25 downto 21);
regB_sel<= op_code_in(20 downto 16);
regC_sel<= op_code_in(15 downto 11);
func<= op_code_in(5 downto 0);
shamt<= "000000000000000000000000000"&op_code_in(10 downto 6);
immediate <= op_code_in(15)&"0000000000000000"& op_code_in(14 downto 0);
jmp_addr<= op_code_in(25 downto 0);

end struct;