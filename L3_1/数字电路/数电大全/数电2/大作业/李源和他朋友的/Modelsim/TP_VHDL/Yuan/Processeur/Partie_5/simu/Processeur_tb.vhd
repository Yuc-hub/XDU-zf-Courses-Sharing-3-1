LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity Processeur_tb IS

END entity ;


architecture BENCH of Processeur_tb is


	
	signal Clk  :  std_logic := '0';
	signal rst:  std_logic;
	signal Done : boolean := False; 
	constant Period : time := 20 ns;
	
begin

	UUT : entity work.Processeur port map(
	clk=>clk, rst=> rst); 
	
	
	CLK <= '0' when Done else not CLK after Period / 2;
	Rst <= '1', '0' after 5 ns; 
	
	process
	begin 
	wait for 2000 ns; 
	Done <= True; 
	wait; 
	end process; 
	
	

end architecture;