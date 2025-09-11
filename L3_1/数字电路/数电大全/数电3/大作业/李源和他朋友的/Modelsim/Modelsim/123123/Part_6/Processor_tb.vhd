-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com
-- Date : 28/05/2022

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Processor_tb IS
end entity ;


architecture BENCH of Processor_tb is

	signal Clk : std_logic := '0';
	signal rst : std_logic;
	signal OUI : boolean := False; 
	
begin

UUT : entity work.Processor port map(
clk=>clk, rst=> rst); 
	
CLK <= '0' when OUI else not CLK after 10 NS;
Rst <= '1', '0' after 5 ns;
	
process
begin
wait for 1000 ns;
OUI <= True;
wait;
end process;
end architecture;