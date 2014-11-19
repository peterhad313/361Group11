library ieee;
use ieee.std_logic_1164.all;

entity register_file is   
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
end register_file;

architecture structual of register_file is

  component ddf_32 is 
  port(
    clock : in std_logic;
    input : in std_logic_vector(31 downto 0);
    output: out std_logic_vector(31 downto 0)
    );
  end component;

  component and_gate is
  port (
    x   : in  std_logic;
    y   : in  std_logic;
    z   : out std_logic
    );
  end component;


  component mux32_32 is
  port (
   in0	 : in  std_logic_vector(31 downto 0);
   in1	 : in  std_logic_vector(31 downto 0);
   in2	 : in  std_logic_vector(31 downto 0);
   in3	 : in  std_logic_vector(31 downto 0);
   in4	 : in  std_logic_vector(31 downto 0);
   in5	 : in  std_logic_vector(31 downto 0);
   in6	 : in  std_logic_vector(31 downto 0);
   in7	 : in  std_logic_vector(31 downto 0);
   in8	 : in  std_logic_vector(31 downto 0);
   in9	 : in  std_logic_vector(31 downto 0);
   in10	: in  std_logic_vector(31 downto 0);
   in11	: in  std_logic_vector(31 downto 0);
   in12	: in  std_logic_vector(31 downto 0);
   in13	: in  std_logic_vector(31 downto 0);
   in14	: in  std_logic_vector(31 downto 0);
   in15	: in  std_logic_vector(31 downto 0);
   in16	: in  std_logic_vector(31 downto 0);
   in17	: in  std_logic_vector(31 downto 0);
   in18	: in  std_logic_vector(31 downto 0);
   in19	: in  std_logic_vector(31 downto 0);
   in20	: in  std_logic_vector(31 downto 0);
   in21	: in  std_logic_vector(31 downto 0);
   in22	: in  std_logic_vector(31 downto 0);
   in23	: in  std_logic_vector(31 downto 0);
   in24	: in  std_logic_vector(31 downto 0);
   in25	: in  std_logic_vector(31 downto 0);
   in26	: in  std_logic_vector(31 downto 0);
   in27	: in  std_logic_vector(31 downto 0);
   in28	: in  std_logic_vector(31 downto 0);
   in29	: in  std_logic_vector(31 downto 0);
   in30	: in  std_logic_vector(31 downto 0);
   in31	: in  std_logic_vector(31 downto 0);

   sel	: in  std_logic_vector(4 downto 0);
   output	: out std_logic_vector(31 downto 0)
   );
  end component;

  component dec_32 is
  port (
    src : in std_logic_vector(4 downto 0);
    z : out std_logic_vector(31 downto 0)
    );
  end component;

  signal write0: std_logic;
  signal write1: std_logic;
  signal write2: std_logic;
  signal write3: std_logic;
  signal write4: std_logic;
  signal write5: std_logic;
  signal write6: std_logic;
  signal write7: std_logic;
  signal write8: std_logic;
  signal write9: std_logic;
  signal write10: std_logic;
  signal write11: std_logic;
  signal write12: std_logic;
  signal write13: std_logic;
  signal write14: std_logic;
  signal write15: std_logic;
  signal write16: std_logic;
  signal write17: std_logic;
  signal write18: std_logic;
  signal write19: std_logic;
  signal write20: std_logic;
  signal write21: std_logic;
  signal write22: std_logic;
  signal write23: std_logic;
  signal write24: std_logic;
  signal write25: std_logic;
  signal write26: std_logic;
  signal write27: std_logic;
  signal write28: std_logic;
  signal write29: std_logic;
  signal write30: std_logic;
  signal write31: std_logic;

  signal out0: std_logic_vector(31 downto 0);
  signal out1: std_logic_vector(31 downto 0);
  signal out2: std_logic_vector(31 downto 0);
  signal out3: std_logic_vector(31 downto 0);
  signal out4: std_logic_vector(31 downto 0);
  signal out5: std_logic_vector(31 downto 0);
  signal out6: std_logic_vector(31 downto 0);
  signal out7: std_logic_vector(31 downto 0);
  signal out8: std_logic_vector(31 downto 0);
  signal out9: std_logic_vector(31 downto 0);
  signal out10: std_logic_vector(31 downto 0);
  signal out11: std_logic_vector(31 downto 0);
  signal out12: std_logic_vector(31 downto 0);
  signal out13: std_logic_vector(31 downto 0);
  signal out14: std_logic_vector(31 downto 0);
  signal out15: std_logic_vector(31 downto 0);
  signal out16: std_logic_vector(31 downto 0);
  signal out17: std_logic_vector(31 downto 0);
  signal out18: std_logic_vector(31 downto 0);
  signal out19: std_logic_vector(31 downto 0);
  signal out20: std_logic_vector(31 downto 0);
  signal out21: std_logic_vector(31 downto 0);
  signal out22: std_logic_vector(31 downto 0);
  signal out23: std_logic_vector(31 downto 0);
  signal out24: std_logic_vector(31 downto 0);
  signal out25: std_logic_vector(31 downto 0);
  signal out26: std_logic_vector(31 downto 0);
  signal out27: std_logic_vector(31 downto 0);
  signal out28: std_logic_vector(31 downto 0);
  signal out29: std_logic_vector(31 downto 0);
  signal out30: std_logic_vector(31 downto 0);
  signal out31: std_logic_vector(31 downto 0);

  signal decoded:std_logic_vector(31 downto 0);

  begin
    decode0: dec_32 port map (writeRegSel,decoded);

    and0: and_gate port map (decoded(0),clock,write0);
    and1: and_gate port map (decoded(1),clock,write1);
    and2: and_gate port map (decoded(2),clock,write2);
    and3: and_gate port map (decoded(3),clock,write3);
    and4: and_gate port map (decoded(4),clock,write4);
    and5: and_gate port map (decoded(5),clock,write5);
    and6: and_gate port map (decoded(6),clock,write6);
    and7: and_gate port map (decoded(7),clock,write7);
    and8: and_gate port map (decoded(8),clock,write8);
    and9: and_gate port map (decoded(9),clock,write9);
    and10: and_gate port map (decoded(10),clock,write10);
    and11: and_gate port map (decoded(11),clock,write11);
    and12: and_gate port map (decoded(12),clock,write12);
    and13: and_gate port map (decoded(13),clock,write13);
    and14: and_gate port map (decoded(14),clock,write14);
    and15: and_gate port map (decoded(15),clock,write15);
    and16: and_gate port map (decoded(16),clock,write16);
    and17: and_gate port map (decoded(17),clock,write17);
    and18: and_gate port map (decoded(18),clock,write18);
    and19: and_gate port map (decoded(19),clock,write19);
    and20: and_gate port map (decoded(20),clock,write20);
    and21: and_gate port map (decoded(21),clock,write21);
    and22: and_gate port map (decoded(22),clock,write22);
    and23: and_gate port map (decoded(23),clock,write23);
    and24: and_gate port map (decoded(24),clock,write24);
    and25: and_gate port map (decoded(25),clock,write25);
    and26: and_gate port map (decoded(26),clock,write26);
    and27: and_gate port map (decoded(27),clock,write27);
    and28: and_gate port map (decoded(28),clock,write28);
    and29: and_gate port map (decoded(29),clock,write29);
    and30: and_gate port map (decoded(30),clock,write30);
    and31: and_gate port map (decoded(31),clock,write31);

    dff0: ddf_32 port map (write0,input,out0);
    dff1: ddf_32 port map (write1,input,out1);
    dff2: ddf_32 port map (write2,input,out2);
    dff3: ddf_32 port map (write3,input,out3);
    dff4: ddf_32 port map (write4,input,out4);
    dff5: ddf_32 port map (write5,input,out5);
    dff6: ddf_32 port map (write6,input,out6);
    dff7: ddf_32 port map (write7,input,out7);
    dff8: ddf_32 port map (write8,input,out8);
    dff9: ddf_32 port map (write9,input,out9);
    dff10: ddf_32 port map (write10,input,out10);
    dff11: ddf_32 port map (write11,input,out11);
    dff12: ddf_32 port map (write12,input,out12);
    dff13: ddf_32 port map (write13,input,out13);
    dff14: ddf_32 port map (write14,input,out14);
    dff15: ddf_32 port map (write15,input,out15);
    dff16: ddf_32 port map (write16,input,out16);
    dff17: ddf_32 port map (write17,input,out17);
    dff18: ddf_32 port map (write18,input,out18);
    dff19: ddf_32 port map (write19,input,out19);
    dff20: ddf_32 port map (write20,input,out20);
    dff21: ddf_32 port map (write21,input,out21);
    dff22: ddf_32 port map (write22,input,out22);
    dff23: ddf_32 port map (write23,input,out23);
    dff24: ddf_32 port map (write24,input,out24);
    dff25: ddf_32 port map (write25,input,out25);
    dff26: ddf_32 port map (write26,input,out26);
    dff27: ddf_32 port map (write27,input,out27);
    dff28: ddf_32 port map (write28,input,out28);
    dff29: ddf_32 port map (write29,input,out29);
    dff30: ddf_32 port map (write30,input,out30);
    dff31: ddf_32 port map (write31,input,out31);

    mux1: mux32_32 port map (out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28,out29,out30,out31,regASel,outA);
    mux2: mux32_32 port map (out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28,out29,out30,out31,regBSel,outB);
end structual;