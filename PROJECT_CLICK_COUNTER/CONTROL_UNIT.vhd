--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

--10011100001111 is 9999 in binary

entity CONTROL_UNIT is
	port(CLK,RESET,REVERSE: in STD_LOGIC;
	IS_LEFT: out STD_LOGIC;
	CAT: out STD_LOGIC_VECTOR(0 to 6);
	ANO: out STD_LOGIC_VECTOR(3 downto 0);
	COUNTER: inout INTEGER:=0);
end;

architecture a1 of CONTROL_UNIT is

component SEVEN_SEG_DISPLAY is
	port(RESET,CLK: in STD_LOGIC;
	N1,N2,N3,N4: in STD_LOGIC_VECTOR(3 downto 0);
	CAT: out STD_LOGIC_VECTOR(0 to 6);
	ANO: out STD_LOGIC_VECTOR(3 downto 0));
end component;

component DECODER_DEC is
	port(nr: in INTEGER;
	output: out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal first:INTEGER:=COUNTER/1000;
signal second:INTEGER:=(COUNTER mod 1000)/100;
signal third:INTEGER:=(COUNTER mod 100)/10;
signal forth:INTEGER:=COUNTER mod 10;

signal first_bin:STD_LOGIC_VECTOR(3 downto 0):="0000";
signal second_bin:STD_LOGIC_VECTOR(3 downto 0):="0000";
signal third_bin:STD_LOGIC_VECTOR(3 downto 0):="0000";
signal forth_bin:STD_LOGIC_VECTOR(3 downto 0):="0000";

begin
	IS_LEFT<=not REVERSE;
	first_number: DECODER_DEC port map(first,first_bin);
	second_number: DECODER_DEC port map(second,second_bin);
	third_number: DECODER_DEC port map(third,third_bin);
	forth_number: DECODER_DEC port map(forth,forth_bin);
	
	DISPLAY: SEVEN_SEG_DISPLAY port map(RESET,CLK,FIRST_BIN,SECOND_BIN,THIRD_BIN,FORTH_BIN,CAT,ANO);
	
end;
