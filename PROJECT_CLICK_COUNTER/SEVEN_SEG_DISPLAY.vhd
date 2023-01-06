--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SEVEN_SEG_DISPLAY is
	port(RESET,CLK: in STD_LOGIC;
	N1,N2,N3,N4: in STD_LOGIC_VECTOR(3 downto 0);
	CAT: out STD_LOGIC_VECTOR(0 to 6);
	ANO: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture a1 of SEVEN_SEG_DISPLAY is

component MUX is
	port(V1,V2,V3,V4: in STD_LOGIC_VECTOR(3 downto 0);
	S: in STD_LOGIC_VECTOR(1 downto 0);
	OUTPUT: out STD_LOGIC_VECTOR(3 downto 0));
end component;

component DECODER is
	port(nr: in STD_LOGIC_VECTOR(3 downto 0);
	seven_seg: out STD_LOGIC_VECTOR(0 to 6));
end component;

component CLK_100 is
	port(CLOCK: in STD_LOGIC;
	MSB1,MSB2: out STD_LOGIC);
end component;

signal AUX_MUX: STD_LOGIC_VECTOR(1 downto 0);
signal AUX_DECODER: STD_LOGIC_VECTOR(3 downto 0);

begin
	CLOCK: CLK_100 port map(CLK,AUX_MUX(1),AUX_MUX(0));
	MUX1: MUX port map("1110","1101","1011","0111",AUX_MUX,ANO);
	MUX2: MUX port map(N1,N2,N3,N4,AUX_MUX,AUX_DECODER);
	DCD: DECODER port map(AUX_DECODER,CAT);
end;

