LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity AssemblageUdT_tb IS

END entity ;


architecture BENCH of AssemblageUdT_tb is


	signal Ra,Rb,Rw : std_logic_vector(3 downto 0);
	signal AluCtr :  std_logic_vector(1 downto 0);
	signal W :  std_logic_vector(31 downto 0);
	signal Clk  :  std_logic := '0';
	signal rst, RegWr, MemWr, ALUsrc, WrSrc, N :  std_logic;
	signal Imm : std_logic_vector(7 downto 0);
	signal Done : boolean := False; 
	constant Period : time := 20 ns;
	
begin

	UUT : entity work.AssemblageUdT port map(
	Ra => Ra, Rb=> Rb, Rw => Rw, clk=>clk, rst=> rst, RegWr =>RegWr, 
	N => N, MemWr=>MemWr, ALUsrc => ALUsrc, AluCtr => AluCtr,
	WrSrc=> WrSrc, Imm=> Imm, W => W); 
	
	
	CLK <= '0' when Done else not CLK after Period / 2;
	Rst <= '1', '0' after 5 ns; 
	
	
	
	process
	begin
		-- R(1)= R(15) =48 ok
		Ra<= "1111"; -- busA = R(15) 
		Rw<="0001"; -- R(1) <= bus W
		Rb <="0000"; 
		RegWr <='1'; 
		AluCtr <= "11"; -- S = A
		ALUsrc <= '0'; 
		WrSrc <= '0'; 
		MemWr <= '0'; 
		Imm <= "00000000"; 
		wait for 20 ns;
		
		-- R(2) = R(1) + R(15) =96 ok
		Ra<= "0001"; -- busA = R(1) 
		Rw<="0010"; 
		Rb <="1111"; 
		RegWr <='1'; 
		AluCtr <= "00"; -- S = A + B
		ALUsrc <= '0'; 
		WrSrc <= '0'; 
		MemWr <= '0'; 
		wait for 20 ns;
		
		-- R(3) = R(1) + Imm(15) =63 ok
		Ra<= "0001"; -- busA = R(1) 
		Rw<="0011"; 
		--Rb <="1111"; 
		RegWr <='1'; 
		AluCtr <= "00"; -- S = A + B
		ALUsrc <= '1'; 
		WrSrc <= '0'; 
		MemWr <= '0'; 
		Imm <= "00001111"; -- Imm = 15
		wait for 20 ns;
		
		-- R(4) = R(5) - R(15) = -48 ok
		Ra<= "0101"; -- busA = R(1) 
		Rw<="0100"; 
		Rb <="1111"; 
		RegWr <='1'; 
		AluCtr <= "10"; -- S = A - B
		ALUsrc <= '0'; 
		WrSrc <= '0'; 
		MemWr <= '0'; 
		wait for 20 ns;
		
		-- R(5) = R(1) - Imm (16) = 32 ok
		Ra<= "0001"; -- busA = R(1) 
		Rw<="0101"; 
		--Rb <="1111"; 
		RegWr <='1'; 
		AluCtr <= "10"; -- S = A - B
		ALUsrc <= '1'; 
		WrSrc <= '0'; 
		MemWr <= '0'; 
		Imm <= "00010000"; -- Imm = 16
		wait for 20 ns;
		
		-- Mem(R1) = R(3) = 63 ok
		Ra<= "0001"; -- Addr = R(1) 
		--Rw<="0101"; 
		Rb <="0011"; --R(3)
		RegWr <='0'; 
		AluCtr <= "11"; -- S = A
		ALUsrc <= '0'; 
		WrSrc <= '0'; 
		MemWr <= '1'; 
		--Imm <= "00010000"; -- Imm = 16
		wait for 20 ns;
		
		-- R(6) = Mem(R1) = 63 ok
		Ra<= "0001"; -- Addr = R(1) 
		Rw<="0110"; --R(6) 
		--Rb <="0011"; --R(3)
		RegWr <='1'; 
		AluCtr <= "11"; -- S = A
		ALUsrc <= '0'; 
		WrSrc <= '1'; 
		MemWr <= '0'; 
		--Imm <= "00010000"; -- Imm = 16
		wait for 20 ns;
		
		Done <= True; 
		wait;
		
	end process;
end architecture;