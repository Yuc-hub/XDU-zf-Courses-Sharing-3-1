LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity UnitTraitement_tb IS

END entity ;


architecture BENCH of UnitTraitement_tb is


	signal Ra,Rb,Rw : std_logic_vector(3 downto 0);
	signal OP :  std_logic_vector(1 downto 0);
	signal W :  std_logic_vector(31 downto 0);
	signal Clk  :  std_logic := '0';
	signal rst, WE, N :  std_logic;
	signal Done : boolean := False; 
	constant Period : time := 20 ns;
	
begin

	UUT : entity work.UnitTraitement port map(
	Ra => Ra, Rb=> Rb, Rw => Rw, clk=>clk, rst=> rst, WE =>WE, 
	N => N, W=>W, OP => OP); 
	
	
	CLK <= '0' when Done else not CLK after Period / 2;
	Rst <= '1', '0' after 5 ns; 
	
	
	
	process
	begin
		-- R(1)= R(15) 
		Ra<= "1111"; -- busA = R(15) 
		Rw<="0001"; -- R(1) <= bus W
		Rb <="0000"; 
		WE <='1'; 
		OP <= "11"; -- S = A
		wait for 20 ns;
		-- R(1) = R(1) + R(15)
		Ra<= "1111"; 
		Rw<="0001";
		Rb <="0001"; 
		WE <='1'; 
		OP <= "00"; -- S = A + B
		wait for 20 ns;
		-- R(2) = R(1) + R(15)
		Ra<="1111"; 
		Rb<="0001"; 
		Rw<="0010";
		WE<='1'; 
		OP<= "00"; -- S = A + B
		wait for 20 ns;
		-- R(3) = R(1) - R(15)
		Ra<="0001"; 
		Rb<="1111"; 
		Rw<="0011";
		WE<='1'; 
		OP<= "10"; -- S = A - B
		wait for 20 ns;
		-- R(5) = R(7) - R(15)
		Ra<="0111"; 
		Rb<="1111"; 
		Rw<="0101";
		WE<='1'; 
		OP<= "10"; -- S = A - B
		wait for 20 ns;
		Done <= True; 
		wait;
		
	end process;
end architecture;