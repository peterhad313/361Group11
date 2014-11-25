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

  component mux_32 is
  port (
  sel   : in  std_logic;
  src0  : in  std_logic_vector(31 downto 0);
  src1  : in  std_logic_vector(31 downto 0);
  z     : out std_logic_vector(31 downto 0)
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

  signal muxed0: std_logic_vector(31 downto 0);
  signal muxed1: std_logic_vector(31 downto 0);
  signal muxed2: std_logic_vector(31 downto 0);
  signal muxed3: std_logic_vector(31 downto 0);
  signal muxed4: std_logic_vector(31 downto 0);
  signal muxed5: std_logic_vector(31 downto 0);
  signal muxed6: std_logic_vector(31 downto 0);
  signal muxed7: std_logic_vector(31 downto 0);
  signal muxed8: std_logic_vector(31 downto 0);
  signal muxed9: std_logic_vector(31 downto 0);
  signal muxed10: std_logic_vector(31 downto 0);
  signal muxed11: std_logic_vector(31 downto 0);
  signal muxed12: std_logic_vector(31 downto 0);
  signal muxed13: std_logic_vector(31 downto 0);
  signal muxed14: std_logic_vector(31 downto 0);
  signal muxed15: std_logic_vector(31 downto 0);
  signal muxed16: std_logic_vector(31 downto 0);
  signal muxed17: std_logic_vector(31 downto 0);
  signal muxed18: std_logic_vector(31 downto 0);
  signal muxed19: std_logic_vector(31 downto 0);
  signal muxed20: std_logic_vector(31 downto 0);
  signal muxed21: std_logic_vector(31 downto 0);
  signal muxed22: std_logic_vector(31 downto 0);
  signal muxed23: std_logic_vector(31 downto 0);
  signal muxed24: std_logic_vector(31 downto 0);
  signal muxed25: std_logic_vector(31 downto 0);
  signal muxed26: std_logic_vector(31 downto 0);
  signal muxed27: std_logic_vector(31 downto 0);
  signal muxed28: std_logic_vector(31 downto 0);
  signal muxed29: std_logic_vector(31 downto 0);
  signal muxed30: std_logic_vector(31 downto 0);
  signal muxed31: std_logic_vector(31 downto 0);

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
  signal writeAndClock: std_logic;

  begin
    decode0: dec_32 port map (writeRegSel,decoded);

    and0: and_gate port map (decoded(0),writeEnable,write0);
    and1: and_gate port map (decoded(1),writeEnable,write1);
    and2: and_gate port map (decoded(2),writeEnable,write2);
    and3: and_gate port map (decoded(3),writeEnable,write3);
    and4: and_gate port map (decoded(4),writeEnable,write4);
    and5: and_gate port map (decoded(5),writeEnable,write5);
    and6: and_gate port map (decoded(6),writeEnable,write6);
    and7: and_gate port map (decoded(7),writeEnable,write7);
    and8: and_gate port map (decoded(8),writeEnable,write8);
    and9: and_gate port map (decoded(9),writeEnable,write9);
    and10: and_gate port map (decoded(10),writeEnable,write10);
    and11: and_gate port map (decoded(11),writeEnable,write11);
    and12: and_gate port map (decoded(12),writeEnable,write12);
    and13: and_gate port map (decoded(13),writeEnable,write13);
    and14: and_gate port map (decoded(14),writeEnable,write14);
    and15: and_gate port map (decoded(15),writeEnable,write15);
    and16: and_gate port map (decoded(16),writeEnable,write16);
    and17: and_gate port map (decoded(17),writeEnable,write17);
    and18: and_gate port map (decoded(18),writeEnable,write18);
    and19: and_gate port map (decoded(19),writeEnable,write19);
    and20: and_gate port map (decoded(20),writeEnable,write20);
    and21: and_gate port map (decoded(21),writeEnable,write21);
    and22: and_gate port map (decoded(22),writeEnable,write22);
    and23: and_gate port map (decoded(23),writeEnable,write23);
    and24: and_gate port map (decoded(24),writeEnable,write24);
    and25: and_gate port map (decoded(25),writeEnable,write25);
    and26: and_gate port map (decoded(26),writeEnable,write26);
    and27: and_gate port map (decoded(27),writeEnable,write27);
    and28: and_gate port map (decoded(28),writeEnable,write28);
    and29: and_gate port map (decoded(29),writeEnable,write29);
    and30: and_gate port map (decoded(30),writeEnable,write30);
    and31: and_gate port map (decoded(31),writeEnable,write31);

    mux0: mux_32 port map  (write0 , out0 ,input,muxed0 );
    mux1: mux_32 port map  (write1 , out1 ,input,muxed1 );
    mux2: mux_32 port map  (write2 , out2 ,input,muxed2 );
    mux3: mux_32 port map  (write3 , out3 ,input,muxed3 );
    mux4: mux_32 port map  (write4 , out4 ,input,muxed4 );
    mux5: mux_32 port map  (write5 , out5 ,input,muxed5 );
    mux6: mux_32 port map  (write6 , out6 ,input,muxed6 );
    mux7: mux_32 port map  (write7 , out7 ,input,muxed7 );
    mux8: mux_32 port map  (write8 , out8 ,input,muxed8 );
    mux9: mux_32 port map  (write9 , out9 ,input,muxed9 );
    mux10: mux_32 port map (write10, out10,input,muxed10);
    mux11: mux_32 port map (write11, out11,input,muxed11);
    mux12: mux_32 port map (write12, out12,input,muxed12);
    mux13: mux_32 port map (write13, out13,input,muxed13);
    mux14: mux_32 port map (write14, out14,input,muxed14);
    mux15: mux_32 port map (write15, out15,input,muxed15);
    mux16: mux_32 port map (write16, out16,input,muxed16);
    mux17: mux_32 port map (write17, out17,input,muxed17);
    mux18: mux_32 port map (write18, out18,input,muxed18);
    mux19: mux_32 port map (write19, out19,input,muxed19);
    mux20: mux_32 port map (write20, out20,input,muxed20);
    mux21: mux_32 port map (write21, out21,input,muxed21);
    mux22: mux_32 port map (write22, out22,input,muxed22);
    mux23: mux_32 port map (write23, out23,input,muxed23);
    mux24: mux_32 port map (write24, out24,input,muxed24);
    mux25: mux_32 port map (write25, out25,input,muxed25);
    mux26: mux_32 port map (write26, out26,input,muxed26);
    mux27: mux_32 port map (write27, out27,input,muxed27);
    mux28: mux_32 port map (write28, out28,input,muxed28);
    mux29: mux_32 port map (write29, out29,input,muxed29);
    mux30: mux_32 port map (write30, out30,input,muxed30);
    mux31: mux_32 port map (write31, out31,input,muxed31);

    dff0:  ddf_32 port map (clock,muxed0 ,out0 );
    dff1:  ddf_32 port map (clock,muxed1 ,out1 );
    dff2:  ddf_32 port map (clock,muxed2 ,out2 );
    dff3:  ddf_32 port map (clock,muxed3 ,out3 );
    dff4:  ddf_32 port map (clock,muxed4 ,out4 );
    dff5:  ddf_32 port map (clock,muxed5 ,out5 );
    dff6:  ddf_32 port map (clock,muxed6 ,out6 );
    dff7:  ddf_32 port map (clock,muxed7 ,out7 );
    dff8:  ddf_32 port map (clock,muxed8 ,out8 );
    dff9:  ddf_32 port map (clock,muxed9 ,out9 );
    dff10: ddf_32 port map (clock,muxed10,out10);
    dff11: ddf_32 port map (clock,muxed11,out11);
    dff12: ddf_32 port map (clock,muxed12,out12);
    dff13: ddf_32 port map (clock,muxed13,out13);
    dff14: ddf_32 port map (clock,muxed14,out14);
    dff15: ddf_32 port map (clock,muxed15,out15);
    dff16: ddf_32 port map (clock,muxed16,out16);
    dff17: ddf_32 port map (clock,muxed17,out17);
    dff18: ddf_32 port map (clock,muxed18,out18);
    dff19: ddf_32 port map (clock,muxed19,out19);
    dff20: ddf_32 port map (clock,muxed20,out20);
    dff21: ddf_32 port map (clock,muxed21,out21);
    dff22: ddf_32 port map (clock,muxed22,out22);
    dff23: ddf_32 port map (clock,muxed23,out23);
    dff24: ddf_32 port map (clock,muxed24,out24);
    dff25: ddf_32 port map (clock,muxed25,out25);
    dff26: ddf_32 port map (clock,muxed26,out26);
    dff27: ddf_32 port map (clock,muxed27,out27);
    dff28: ddf_32 port map (clock,muxed28,out28);
    dff29: ddf_32 port map (clock,muxed29,out29);
    dff30: ddf_32 port map (clock,muxed30,out30);
    dff31: ddf_32 port map (clock,muxed31,out31);

    bmux1: mux32_32 port map (out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28,out29,out30,out31,regASel,outA);
    bmux2: mux32_32 port map (out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28,out29,out30,out31,regBSel,outB);
end structual;