library ieee;
use ieee.std_logic_1164.all;

-- 4-to-1 Mux
entity mux_4_to_1 is
   port( 
		D0, D1, D2, D3			: in std_logic; -- the options
		ctrl_dec				: in std_logic_vector(4 downto 0); -- the selector switches
		F 						: out std_logic --output
		);
end mux_4_to_1;
--
architecture struct of mux_4_to_1 is
   signal and_out0, and_out1, and_out2, and_out3 : std_logic;
   signal or_out0, or_out1 : std_logic;

begin
	--AND gates
	and0: entity work.and_gate
		port map (x=>ctrl_dec(0), y=>D0, z=>and_out0);
	and1: entity work.and_gate
		port map (x=>ctrl_dec(1), y=>D1, z=>and_out1);
	and2: entity work.and_gate
		port map (x=>ctrl_dec(2), y=>D2, z=>and_out2);
	and3: entity work.and_gate
		port map (x=>ctrl_dec(3), y=>D3, z=>and_out3);
	--OR gates
	or0: entity work.or_gate
		port map (x=>and_out0, y=>and_out1, z=>or_out0);
	or1: entity work.or_gate
		port map (x=>and_out2, y=>and_out3, z=>or_out1);
	or2: entity work.or_gate
		port map (x=>or_out0, y=>or_out1, z=>F);

end struct;