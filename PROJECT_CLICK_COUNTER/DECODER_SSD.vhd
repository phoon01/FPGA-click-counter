--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DECODER is
	port(nr: in STD_LOGIC_VECTOR(3 downto 0);
	seven_seg: out STD_LOGIC_VECTOR(0 to 6));
end;

architecture a1 of DECODER is
begin
	process(nr)
	begin
		case nr is
			when X"0" => seven_seg<="0000001";
			when X"1" => seven_seg<="1001111";
			when X"2" => seven_seg<="0010010";
			when X"3" => seven_seg<="0000110";
			when X"4" => seven_seg<="1001100";
			when X"5" => seven_seg<="0100100";
			when X"6" => seven_seg<="0100000";
			when X"7" => seven_seg<="0001110";
			when X"8" => seven_seg<="0000000";
			when X"9" => seven_seg<="0000100";
			when others => seven_seg<="0110000";
		end case;
	end process;
end;
