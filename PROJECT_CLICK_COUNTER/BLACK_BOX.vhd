--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity BLACK_BOX is
	 port(
		 MOUSE_INPUT : in STD_LOGIC;
		 CLK : in STD_LOGIC;
		 PS2_CLK : in STD_LOGIC;
		 RESET : in STD_LOGIC;
		 REVERSE : in STD_LOGIC;
		 CAT: out STD_LOGIC_VECTOR(0 to 6);
		 ANO: out STD_LOGIC_VECTOR(3 downto 0);
		 IS_LEFT : out STD_LOGIC
	     );
end BLACK_BOX;

architecture a1 of BLACK_BOX is

component CONTROL_UNIT is
	port(CLK,RESET,REVERSE: in STD_LOGIC;
	IS_LEFT: out STD_LOGIC;
	CAT: out STD_LOGIC_VECTOR(0 to 6);
	ANO: out STD_LOGIC_VECTOR(3 downto 0);
	COUNTER: inout INTEGER:=0);
end component;

component EXECUTION_UNIT is
	port(CLK,RESET: in STD_LOGIC;
	MOUSE_INPUT: in STD_LOGIC;
	COUNTER: inout INTEGER:=0;
	REVERSE: in STD_LOGIC);	
end component;

signal COUNTER:INTEGER:=0;

begin
	--we can call the control unit because it has the seven segment display wihich requires the FPGA clock and I didn't implement it on the board
	--CONTROL: CONTROL_UNIT port map(CLK,RESET,REVERSE,IS_LEFT,CAT,ANO,COUNTER);
	EXECUTION: EXECUTION_UNIT port map(PS2_CLK,RESET,MOUSE_INPUT,COUNTER,REVERSE); --my counter is inout because we need the value from the CU to EU and vice-versa
	
end;
