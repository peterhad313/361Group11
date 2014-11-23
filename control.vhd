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
	alu   : out std_logic_vector(3 downto 0) --ALU control
  );
end control;

architecture structural of control is
--signals from 6-input and gates

component not_gate is
  port (
    x   : in  std_logic;
    z   : out std_logic
  );
end component;

component and_6 is

  port (
   	a   : in  std_logic;
	b   : in  std_logic;
	c   : in  std_logic;
	d   : in  std_logic;
	e   : in  std_logic;
	f   : in  std_logic;
	z   : out std_logic
  );
end component;

component or_4 is
 
  port (
    	a   : in  std_logic;
    	b   : in  std_logic;
    	c   : in std_logic;
	d   : in std_logic;
	z   : out std_logic
  );
end component;

component or_3 is
 
  port (
    	a   : in  std_logic;
    	b   : in  std_logic;
    	c   : in std_logic;
	z   : out std_logic
  );
end component;

component and_8 is

  port (
  a   : in  std_logic;
	b   : in  std_logic;
	c   : in  std_logic;
	d   : in  std_logic;
	e   : in  std_logic;
	f   : in  std_logic;
  g   : in std_logic;
  h   : in std_logic;
	z   : out std_logic
  );
end component;


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
signal not_lw: std_logic;
signal not_andx: std_logic;
signal not_orx:std_logic;
signal not_sllx: std_logic;
signal not_slt: std_logic;
signal alu0temp: std_logic;
--signal alu1temp: std_logic;

signal useFunc: std_logic;



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

funcCheck: and_6 port map (not1,not2,not3,not4,not5,not6,useFunc);

--inverters for and gate signals that feed final or gates
not_beq_map: not_gate port map (x => beq, z => not_beq);
not_bne_map: not_gate port map (x => bne, z => not_bne);
not_lw_map: not_gate port map (x => lw, z => not_lw);
not_sw_map: not_gate port map (x => sw, z => not_sw);

not_andx_map: not_gate port map (x => andx, z => not_andx);
not_orx_map: not_gate port map (x => orx, z => not_orx);
not_sllx_map: not_gate port map (x => sllx, z => not_sllx);
not_slt_map: not_gate port map (x => slt, z => not_slt);

--main 6-input and gates for opcode-based signals

beq_map: and_6 port map (a => not1, b => not2, c => not3, d => opcode(2), e => not5, f => not6, z => beq);
bne_map: and_6 port map (a => not1, b => not2, c => not3, d => opcode(2), e => not5, f => opcode(0), z => bne);
addi_map: and_6 port map (a => not1, b => not2, c => opcode(3), d => not4, e => not5, f => not6, z => addi);
lw_map: and_6 port map (a => opcode(5), b => not2, c => not3, d => not4, e => opcode(1), f => opcode(0), z => lw);
sw_map: and_6 port map (a => opcode(5), b => not2, c => opcode(3), d => not4, e => opcode(1), f => opcode(0), z => sw);

--main 6-input and gates for function-based signals

add_map: and_8 port map ( func(5), notf2, notf3, notf4, notf5, notf6, '1', useFunc, add);
addu_map: and_8 port map ( func(5), notf2, notf3, notf4, notf5, func(0),'1', useFunc, addu);
and_map: and_8 port map ( func(5), notf2, notf3, func(2), notf5, notf6, '1', useFunc, andx);
or_map: and_8 port map ( func(5), notf2, notf3, func(2), notf5, func(0), '1', useFunc, orx);
sll_map: and_8 port map ( notf1, notf2, notf3, notf4, notf5, notf6, '1', useFunc, sllx);
slt_map: and_8 port map ( func(5), notf2, func(3), notf4, func(1), notf6, '1', useFunc, slt);
sltu_map: and_8 port map ( func(5), notf2, func(3), notf4, func(1), func(0), '1', useFunc, sltu);
sub_map: and_8 port map ( func(5), notf2, notf3, notf4, func(1), notf6, '1', useFunc, sub);
subu_map: and_8 port map ( func(5), notf2, notf3, notf4, func(1), notf6, '1', useFunc, subu);

--main or gates to output signals
or_rw_map: and_6 port map (not_beq, not_bne, not_sw,'1','1','1',rw);
or_mux_ALU: or_4 port map(sllx, addi, lw, sw, mux_ALU);
mux_write<= not_lw;
or_branch: or_4 port map(bne,beq,'0','0',br);
eq<=beq;
memrd<=lw;
memwr<=sw;
alu(3)<='0'; 
or_alu2: or_4 port map (slt,sltu,sllx,'0', alu(2));
or_alu1: and_6 port map(not_andx,not_orx,not_sllx,not_slt,'1','1',alu(1));
--notx: not_gate port map (alu1temp,);
or_alu01: or_4 port map (orx,slt,sub,subu,alu0temp);
or_alu02: or_4 port map (alu0temp,beq,bne,'0',alu(0));
end architecture structural;