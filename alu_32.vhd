library ieee;
use ieee.std_logic_1164.all;

entity alu_32 is
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

architecture struct of alu_32 is
	signal add_ctemp, sub_ctemp, sll_ctemp	: std_logic_vector(31 downto 0);
	signal sig_slt, sig_sltu			   	: std_logic_vector(31 downto 0);
	signal slt_temp, sig_slt_temp			: std_logic;
	signal sltu_temp						: std_logic;
	signal R_temp							: std_logic_vector(31 downto 0);
	signal ze_temp							: std_logic_vector(31 downto 0);
	signal ze_not							: std_logic;
	signal read_R							: std_logic_vector(31 downto 0);
	signal read_cout						: std_logic;
	signal ctrl_dec							: std_logic_vector(15 downto 0);
	signal ovf_temp1, ovf_temp2				: std_logic;
	signal ovf_neg, ovf_pos					: std_logic;
	signal A_not, B_not, R_not				: std_logic;
begin
	--Decode the control signal
	my_dec_4: entity work.dec_n generic map(n=>4)
		port map (src=>ctrl, z=>ctrl_dec);
	
	sig_slt(31 downto 1)<="0000000000000000000000000000000";
	sig_sltu(31 downto 1)<="0000000000000000000000000000000";
	--Connect 32 bit_alu units
	BA0: entity work.bit_alu
		port map (
			ctrl=>ctrl_dec(6 downto 0),
			A=>A(0), B=>B(0),
			cin_add=>'0', cin_sub=>'1', cin_sll=>'0', z_in=>'1',
			add_cout=>add_ctemp(0), sub_cout=>sub_ctemp(0), sll_cout=>sll_ctemp(0),
			slt_out=>slt_temp, sltu_out=>sltu_temp, z_out=>ze_temp(0),
			R=>R_temp(0)
		);
		
	Gen_BA: 
	for i in 1 to 30 generate
		BAX: entity work.bit_alu 
		port map (
			ctrl=>ctrl_dec(6 downto 0),
			A=>A(i), B=>B(i),
			cin_add=>add_ctemp(i-1), cin_sub=>sub_ctemp(i-1), cin_sll=>sll_ctemp(i-1), z_in=>ze_temp(i-1),
			add_cout=>add_ctemp(i), sub_cout=>sub_ctemp(i), sll_cout=>sll_ctemp(i),
			slt_out=> slt_temp, sltu_out=>sltu_temp, z_out=>ze_temp(i),
			R=>R_temp(i)
		);
	end generate;
	
	BA31: entity work.bit_alu
	port map (
		ctrl=>ctrl_dec(6 downto 0),
		A=>A(31), B=>B(31),
		cin_add=>add_ctemp(30), cin_sub=>sub_ctemp(30), cin_sll=>sll_ctemp(30), z_in=>ze_temp(30),
		add_cout=>add_ctemp(31), sub_cout=>sub_ctemp(31), sll_cout=>sll_ctemp(31),
		slt_out=>sig_slt(0), sltu_out=>sig_sltu(0), z_out=>ze,
		R=>R_temp(31)
		);
	
	--Set output cout
	mux2: entity work.mux_3_to_1
		port map (
			D0=>add_ctemp(31), D1=>sub_ctemp(31), D2=>sll_ctemp(31), ctrl_dec=>ctrl_dec(4 downto 2), F=>cout
		);
	
	--Set overflow
	--(A and B and R') or (A' and B' and R)
	not1: entity work.not_gate
		port map (
			x=>A(31), z=>A_not
		);
	not2: entity work.not_gate	
		port map (
			x=>B(31), z=>B_not
		);
	not3: entity work.not_gate
		port map (
			x=>R_temp(31), z=>R_not
		);
	and1: entity work.and_gate
		port map (
			x=>A(31), y=>B(31), z=>ovf_neg
		);
	and2: entity work.and_gate
		port map (
			x=>ovf_neg, y=>R_not, z=>ovf_temp1
		);
	and3: entity work.and_gate
		port map (
			x=>A_not, y=>B_not, z=>ovf_pos
		);
	and4: entity work.and_gate
		port map (
			x=>ovf_pos, y=>R_temp(31), z=>ovf_temp2
		);
	or2: entity work.or_gate
		port map (
			x=>ovf_temp1, y=>ovf_temp2, z=>ovf
		);
		
	--Mux to select output R, incorporating slt and sltu
	Gen_MUX:
	for i in 0 to 31 generate
		MUXX: entity work.mux_7_to_1
			port map (
				D0=>R_temp(i), D1=>R_temp(i), D2=>R_temp(i), D3=>R_temp(i), D4=>R_temp(i), D5=>sig_slt(i), D6=>sig_sltu(i), ctrl_dec=>ctrl_dec(6 downto 0), F=>R(i)
			);
	end generate;
	
end struct;