--WORKS
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity EXECUTION_UNIT is
	port(CLK,RESET: in STD_LOGIC;
	MOUSE_INPUT: in STD_LOGIC;
	COUNTER: inout INTEGER:=0;
	REVERSE: in STD_LOGIC);	
end;  

architecture a1 of EXECUTION_UNIT is

signal MOUSE_ARRAY:STD_LOGIC_VECTOR(0 to 32):=(others=>'0');--we will use this to store the 3 11bit words from the mouse input

signal INDEX:STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');--this is the index for the mouse array
	
signal verifok1,verifok2,verifok3:INTEGER:=0;
	
--signal VERIF1,VERIF2,VERIF3:INTEGER:=0;
--signal verifok1,verifok2,verifok3:INTEGER:=0;

begin
	process(CLK,RESET)
	variable word1_parity,word2_parity,word3_parity:INTEGER:=0;
	variable paritybit_1,paritybit_2,paritybit_3:STD_LOGIC:='0';
	variable ok1,ok2,ok3:INTEGER:=0;
	variable COUNT:INTEGER:=COUNTER;
	begin
		if(RESET='1') then
			COUNTER<=0;
			INDEX<="000000";
		else
		if(CLK'EVENT and CLK='0') then --on the falling edge we take the data
			MOUSE_ARRAY(conv_integer(INDEX))<=MOUSE_INPUT;--here we put the mouse input in an array
			if(INDEX="100000") then 
			--if the index is 33 we reset the index
			--when the index is 33 we need to check the parity of each word to see if the signal was transimitted correctly
			
			--first we check if the word is sent succsesful with the odd parity bit by counting the number of 1s if the count is odd and parity bit is 0 and if the count is even then the parity is 1
		for word in 0 to 2 loop	 --we go from word to word
			for bt in 1 to 8 loop --we start counting from the second position because the first bit is always 0 and we stop at the parity bit
				if(MOUSE_ARRAY(word*11+bt)='1') then
					case (word) is
						when 0 => word1_parity:=word1_parity+1;
						when 1 => word2_parity:=word2_parity+1;
						when others => word3_parity:=word3_parity+1;
				end case;
				end if;
			end loop;
		end loop;
		--VERIF1<=word1_parity;
		--VERIF2<=word2_parity;
		--VERIF3<=word3_parity;
		paritybit_1:=MOUSE_ARRAY(9);
		paritybit_3:=MOUSE_ARRAY(20);
		paritybit_2:=MOUSE_ARRAY(31);
		INDEX<="000000";
		--check parity
		
		if((word1_parity mod 2 = 0 and paritybit_1='1') or (word1_parity mod 2 = 1 and paritybit_1='0')) then
			ok1:=1;
		end if;
		
		if((word2_parity mod 2 = 0 and paritybit_2='1') or (word2_parity mod 2 = 1 and paritybit_2='0')) then
			ok2:=1;
		end if;
		
		if((word3_parity mod 2 = 0 and paritybit_3='1') or (word3_parity mod 2 = 1 and paritybit_3='0')) then
			ok3:=1;
		end if;
		
		
		--if all words are good then we can count 
			
			--we need the bits on positions 1 and 2 in MOUSE_ARRAY because that is where we have the mouse button inputs (1 if mouse button is pressed and 0 if  not)
			--if reversed is 0(inactive) then left click increments and right click decrements; if reversed is active then left click decrements and right click increments
			
			if(ok1=1 and ok2=1 and ok3=1) then
			if(REVERSE='0') then --left increments; right decrements
				if(MOUSE_ARRAY(1)='1') then
					COUNT:=COUNT+1;
				end if;
				
				if(MOUSE_ARRAY(2)='1') then
					if(COUNT>=1)then
						COUNT:=COUNT-1;
					end if;
				end if;
				
				COUNTER<=COUNT;
				
			else --left decrementsl right increments
				if(MOUSE_ARRAY(2)='1') then
					COUNT:=COUNT+1;
				end if;
				
				if(MOUSE_ARRAY(1)='1') then
					if(COUNT>=1)then
						COUNT:=COUNT-1;
					end if;
				end if;
				
				COUNTER<=COUNT;
			end if;
			end if;
			
		
		
		
		MOUSE_ARRAY<=(others => '0');
		--VERIF1<=0;
		--VERIF2<=0;
		--VERIF3<=0;
		--verifok1<=0;
		--verifok2<=0;
		--verifok3<=0;
		
			else
			INDEX<=INDEX+1;--index for the array 
				end if;
		end if;
		end if;
	end process;
	
end;

--cases to test
--010010010010100100100101001001001  left button clicked; parity is ok
--001010010010100100100101001001001  right button clicked; parity is ok
--and activate reverse

--in waveform
--first I put in values manually through the signal MOUSE_INPUT; a left click which increments the counter; counter is 1
--then i set the value of MOUSE_ARRAY so that a left click is performed; counter is 2
--then i leave the same value in MOUSE_ARRAY I just activate the REVERSE so the left click decrements; counter is 1
--then i turn off REVERSE and set the value of the MOUSE_ARRAY such that it performs a right click and it decrements; counter is 0
--then i leave the same value in MOUSE_ARRAY and activate reverse so the right click will increment; counter is 1
--then turn of REVERSE so right click decrements; counter is 0
--now i give a right click while the counter is at 0 to see what happens, it should not go below 0; counter is still 0
--now i give a left click with the REVERSE active so the left will decrement and the counter should not go below 0; counter still 0