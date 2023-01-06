--NOT USED
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CONTAINER is
	port(RESET,CLK: in STD_LOGIC;
	CAT: out STD_LOGIC_VECTOR(0 to 6);
	ANO: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture a1 of CONTAINER is	

component SEVEN_SEG_DISPLAY is
	port(RESET,CLK: in STD_LOGIC;
	N1,N2,N3,N4: in STD_LOGIC_VECTOR(3 downto 0);
	CAT: out STD_LOGIC_VECTOR(0 to 6);
	ANO: out STD_LOGIC_VECTOR(3 downto 0));
end component;

begin
	DISPLAY: SEVEN_SEG_DISPLAY port map (RESET,CLK,"1001","0110","0101","0011",CAT,ANO);--instead of "" we put what number we want to display
end;
