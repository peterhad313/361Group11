--Control Signals for Single-Cycle Processor
library ieee;
use ieee.std_logic_1164.all;

entity control is
  port (
    	opcode   : in  std_logic_vector(5 downto 0); --opcode in is 6 bit input
	func : in std_logic_vector(5 downto 0);
    	rw   : out std_logic; --register write
	mux_ALU   : out std_logic; --the pre-ALU mux control
	mux_write  : out std_logic; --the pre-register write mux control
	br   : out std_logic; --branch
	eq   : out std_logic; --branch equal
	memrd  : out std_logic; --memory read
	memwr  : out std_logic; --memory write
	alu   : out std_logic_vector(3 downto 0); --ALU control
  );
end control;

architecture structural of control is
--signals from 6-input and gates

--opcode based signals
signal beq : std_logic;
signal bne : std_logic;
signal addi : std_logic;
signal lw: std_logic;
signal sw: std_logic;

--func based signals
signal add: std_logic;
signal addu: std_logic;
signal andx: std_logic;
signal orx: std_logic;
signal sllx: std_logic;
signal slt: std_logic;
signal sltu: std_logic;
signal sub: std_logic;
signal subu: std_logic;

--or gates for control signal outputs

signal or1: std_logic;
signal or2: std_logic;
signal or3: std_logic;
signal or4: std_logic;
signal or5: std_logic;
signal or6: std_logic;
signal or7: std_logic;

--inverted opcode signals

signal not1: std_logic;
signal not2: std_logic;
signal not3: std_logic;
signal not4: std_logic;
signal not5: std_logic;
signal not6: std_logic;

--inverted func signals

signal notf1: std_logic;
signal notf2: std_logic;
signal notf3: std_logic;
signal notf4: std_logic;
signal notf5: std_logic;
signal notf6: std_logic;

--inverted and gate signals for or gates

signal not_beq: std_logic;
signal not_bne: std_logic;
signal not_sw: std_logic;
signal not_lw: std_logic:


begin
--inverters for opcode signals
not1_map: not_gate port map (x => opcode(5), z => not1);
not2_map: not_gate port map (x => opcode(4), z => not2);
not3_map: not_gate port map (x => opcode(3), z => not3);
not4_map: not_gate port map (x => opcode(2), z => not4);
not5_map: not_gate port map (x => opcode(1), z => not5);
not6_map: not_gate port map (x => opcode(0), z => not6);

--inverters for function signals
notf1_map: not_gate port map (x => func(5), z => notf1);
notf2_map: not_gate port map (x => func(4), z => notf2);
notf3_map: not_gate port map (x => func(3), z => notf3);
notf4_map: not_gate port map (x => func(2), z => notf4);
notf5_map: not_gate port map (x => func(1), z => notf5);
notf6_map: not_gate port map (x => func(0), z => notf6);

--inverters for and gate signals that feed final or gates
not_beq_map: not_gate port map (x => beq, z => not_beq);
not_bne_map: not_gate port map (x => bne, z => not_bne);
not_lw_map: not_gate port map (x => lw, z => not_lw);
not_sw_map: not_gate port map (x => sw, z => not_sw);


--main 6-input and gates for opcode-based signals

beq_map: big_and port map (a => not1, b => not2, c => not3, d => opcode(2), e => not5, f => not6, z => beq);
bne_map: big_and port map (a => not1, b => not2, c => not3, d => opcode(2), e => not5, f => opcode(0), z => bne);
addi_map: big_and port map (a => not1, b => not2, c => opcode(3), d => not4, e => not5, f => not6, z => addi);
lw_map: big_and port map (a => opcode(5), b => not2, c => not3, d => not4, e => opcode(1), f => opcode(0), z => lw);
sw_map: big_and port map (a => opcode(5), b => not2, c => opcode(3), d => not4, e => opcode(1), f => opcode(0), z => lw);

--main 6-input and gates for function-based signals

add_map: big_and port map (a => func(5), b => notf2, c => notf3, d => notf4, e => notf5, f => notf6, z => add);
addu_map: big_and port map (a => func(5), b => notf2, c => notf3, d => notf4, e => notf5, f => func(0), z => addu);
and_map: big_and port map (a => func(5), b => notf2, c => notf3, d => func(2), e => notf5, f => notf6, z => andx);
or_map: big_and port map (a => func(5), b => notf2, c => notf3, d => func(2), e => notf5, f => func(0), z => orx);
sll_map: big_and port map (a => notf1, b => notf2, c => notf3, d => notf4, e => notf5, f => notf6, z => sllx);
slt_map: big_and port map (a => func(5), b => notf2, c => func(3), d => notf4, e => func(1), f => notf6, z => slt);
sltu_map: big_and port map (a => func(5), b => notf2, c => func(3), d => notf4, e => func(1), f => func(0), z => sltu);
sub_map: big_and port map (a => func(5), b => notf2, c => notf3, d => notf4, e => func(1), f => notf6, z => sub);
subu_map: big_and port map (a => func(5), b => notf2, c => notf3, d => notf4, e => func(1), f => notf6, z => subu);

--main or gates to output signals
rw_map: big_or port map (a => not_beq, b => not_bne, c => not_sw);
mux_ALU: bigger_or port map(a => sllx, b => addi, c => lw, d => sw);
--THESE NEED TO BE FINISHED FOR ALL REMAINING SIGNALS^

end architecture structural;