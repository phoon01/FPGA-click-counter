--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity CLK_100 is
	port(CLOCK: in STD_LOGIC;
	MSB1,MSB2: out STD_LOGIC);
end;

architecture a1 of CLK_100 is
begin
	process(CLOCK)
	variable COUNTER:STD_LOGIC_VECTOR(15 downto 0):=(others => '0');
	begin
		if(CLOCK'EVENT and CLOCK='1') then
			COUNTER:=COUNTER+1;
		end if;
		
		MSB1<=COUNTER(15);
		MSB2<=COUNTER(14);
	end process;
end;
