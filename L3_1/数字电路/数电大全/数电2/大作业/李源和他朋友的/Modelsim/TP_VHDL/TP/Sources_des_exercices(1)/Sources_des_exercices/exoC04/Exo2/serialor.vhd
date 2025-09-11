-- Squelette de l'exercice serialor

library IEEE;
use IEEE.Std_logic_1164.all;

entity SerialOR is
  port (Clock,rst, D	: in Std_logic;
        Q		 : out Std_logic);
end entity serialOR;

architecture RTL of SerialOR is
--déclaration des signaux
	signal Q1, Q2, Q3, Q4 : STD_LOGIC;

begin

--instructions concurrente

process(clock,rst) 
begin
if rst = '1' then
	--Q <= '0'; 
	Q1 <= '0'; Q2 <= '0'; Q3 <= '0'; Q4 <= '0'; 
elsif rising_edge(Clock) then
	Q1 <= D;
	Q2 <= Q1;
	Q3 <= Q2;
	Q4 <= Q3;
	--Q <= Q1 or Q2 or Q3 or Q4; FF
end if;
    --instructions séquentielle
end process;
	Q <= Q1 or Q2 or Q3 or Q4;
end architecture RTL;

