--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all; 

entity DECODER_DEC is
	port(nr: in INTEGER:=0;
	output: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture a1 of DECODER_DEC is
begin
	process(nr)
	begin
		case nr is
			when 0 => output<="0000";
			when 1 => output<="0001";
			when 2 => output<="0010";
			when 3 => output<="0011";
			when 4 => output<="0100";
			when 5 => output<="0101";
			when 6 => output<="0110";
			when 7 => output<="0111";
			when 8 => output<="1000";
			when others => output<="1001";
		end case;
	end process;
end;