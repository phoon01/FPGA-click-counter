--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX is
	port(V1,V2,V3,V4: in STD_LOGIC_VECTOR(3 downto 0);
	S: in STD_LOGIC_VECTOR(1 downto 0);
	OUTPUT: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture a1 of MUX is
begin
	process(S,V1,V2,V3,V4)
	begin
		case S is
			when "00" => OUTPUT<=V1;
			when "01" => OUTPUT<=V2;
			when "10" => OUTPUT<=V3;
			when "11" => OUTPUT<=V4;
			when others => OUTPUT<="0000";
		end case;
	end process;
end;
