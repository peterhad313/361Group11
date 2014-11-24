library ieee;
use ieee.std_logic_1164.all;

entity bit_alu is
	port (
		ctrl	: in std_logic_vector(6 downto 0);
		A		: in std_logic;
		B		: in std_logic;
		cin_add	: in std_logic;
		cin_sub	: in std_logic;
		z_in	: in std_logic;
		
		add_cout: out std_logic;
		sub_cout: out std_logic;
		
		slt_out	: out std_logic;
		sltu_out: out std_logic;
		R		: out std_logic;
		z_out	: out std_logic
	);
end bit_alu;

architecture struct of bit_alu is
	signal sig_and, sig_or, sig_add, sig_sub			: std_logic;
	signal b_not										: std_logic;
	signal R_temp										: std_logic;
	signal z_in_not										: std_logic;
	signal sub_cout_temp, sub_sum						: std_logic;
	signal slt_out_temp, sltu_out_temp					: std_logic;
begin
	not1: entity work.not_gate
		port map (
			x=>B, z=>b_not
		);
	and1: entity work.and_gate
		port map (
			x=>A, y=>B, z=>sig_and
		);
	or1: entity work.or_gate
		port map (
			x=>A, y=>B, z=>sig_or
		);
	fa_1: entity work.bit_adder
		port map (
			a=>A, b=>B, cin=>cin_add, sum=>sig_add, cout=>add_cout
		);
	fa_2: entity work.bit_adder
		port map (
			a=>A, b=>b_not, cin=>cin_sub, sum=>sig_sub, cout=>sub_cout_temp
		);
	mux1: entity work.mux_4_to_1
		port map (
			D0=>sig_and, D1=>sig_or, D2=>sig_add, D3=>sig_sub, ctrl_dec=>ctrl(4 downto 0), F=>R_temp
		);
	not2: entity work.not_gate
		port map (
			x=>z_in, z=>z_in_not
		);
	nand1: entity work.nor_gate
		port map (
			x=>R_temp, y=>z_in_not, z=>z_out
		);
		
	--Used to determine sltu
	xor1: entity work.xor_gate
		port map (
			x=>'1', y=>sub_cout_temp, z=>sltu_out_temp
		);	
	--Used to determine slt
	slt_out<=sig_sub;
	-- or2: entity work.or_gate
		-- port map (
			-- x=>sub_sum, y=>sub_cout_temp, z=>slt_out
		-- );
	
	R<=R_temp;
	sub_cout<=sub_cout_temp; 
	sltu_out<=sltu_out_temp;
			
end struct;