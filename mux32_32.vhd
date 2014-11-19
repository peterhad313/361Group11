library ieee;
use ieee.std_logic_1164.all;

entity mux32_32 is
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
end mux32_32;  

architecture struct of mux32_32 is
  component mux_32 is
    port (
  	 sel   : in  std_logic;
  	 src0  : in  std_logic_vector(31 downto 0);
   	src1  : in  std_logic_vector(31 downto 0);
  	 z	    : out std_logic_vector(31 downto 0)
    );
  end component;
  
  component mux_4input is
    port (
	   sel	  : in	std_logic_vector(1 downto 0);
	   src0  : in	std_logic_vector(31 downto 0);
	   src1  :	in	std_logic_vector(31 downto 0);
	   src2  :	in	std_logic_vector(31 downto 0);
	   src3  :	in	std_logic_vector(31 downto 0);
	   z	    : out std_logic_vector(31 downto 0)
    );
  end component;
  
  signal temp1 : std_logic_vector(31 downto 0);
  signal temp2 : std_logic_vector(31 downto 0);
  signal temp3 : std_logic_vector(31 downto 0);
  signal temp4 : std_logic_vector(31 downto 0);
  signal temp5 : std_logic_vector(31 downto 0);
  signal temp6 : std_logic_vector(31 downto 0);
  signal temp7 : std_logic_vector(31 downto 0);
  signal temp8 : std_logic_vector(31 downto 0);

  signal temp11 : std_logic_vector(31 downto 0);
  signal temp12 : std_logic_vector(31 downto 0);

begin
  --process rows one and two
  mux4_1: mux_4input port map (sel(1 downto 0), in0,in1,in2,in3,temp1);
  mux4_2: mux_4input port map (sel(1 downto 0), in4,in5,in6,in7,temp2);
  mux4_3: mux_4input port map (sel(1 downto 0), in8,in9,in10,in11,temp3);
  mux4_4: mux_4input port map (sel(1 downto 0), in12,in13,in14,in15,temp4);
  mux4_5: mux_4input port map (sel(1 downto 0), in16,in17,in18,in19,temp5);
  mux4_6: mux_4input port map (sel(1 downto 0), in20,in21,in22,in23,temp6);
  mux4_7: mux_4input port map (sel(1 downto 0), in24,in25,in26,in27,temp7);
  mux4_8: mux_4input port map (sel(1 downto 0), in28,in29,in30,in31,temp8);
  --begin row 3  
  mux4_11: mux_4input port map (sel(3 downto 2), temp1,temp2,temp3,temp4,temp11);
  mux4_12: mux_4input port map (sel(3 downto 2), temp5,temp6,temp7,temp8,temp12);
    
  --last row
  mux1: mux_32 port map (sel(4), temp11, temp12, output);
  
  
end struct;
