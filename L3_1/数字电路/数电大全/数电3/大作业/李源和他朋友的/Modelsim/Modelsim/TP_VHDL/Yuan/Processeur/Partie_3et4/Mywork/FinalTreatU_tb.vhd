LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity FinalTreatU_tb is
end entity ;

architecture BENCH of FinalTreatU_tb is

	signal Ra,Rb,Rw : std_logic_vector(3 downto 0);
	signal AluCtr :  std_logic_vector(1 downto 0);
	signal W :  std_logic_vector(31 downto 0);
	signal clk  :  std_logic := '0';
	signal rst, RegWr, MemWr, ALUsrc, WrSrc, N :  std_logic;
	signal Imm : std_logic_vector(7 downto 0);
	signal OUI : boolean := False; 
	
begin

UUT : entity work.FinalTreatU port map(
	clk => clk, rst=> rst, RegWr =>RegWr, Ra => Ra, Rb=> Rb, Rw => Rw, 
	ALUsrc => ALUsrc, AluCtr => AluCtr, N => N, MemWr => MemWr, 
	WrSrc => WrSrc, Imm => Imm, W => W);

clk <= '0' when OUI else not CLK after 10 NS;
rst <= '1', '0' after 5 NS; 

process
begin

-- R(1) = R(15) = 48
Ra <= "1111"; -- busA = R(15)
Rb <= "0000"; -- par defaut
Imm <= "00000000"; -- par defaut
ALUsrc <= '0'; -- select busB
AluCtr <= "11"; -- ALUout = S = busA
WrSrc <= '0'; -- busW = S = ALUout
RegWr <='1'; -- write
Rw <= "0001"; -- R(1) <= bus W
MemWr <= '0'; -- non
wait for 20 ns;

-- R(2) = R(1) + R(15) =96
Ra<= "0001"; -- busA = R(1) 
Rw<="0010";
Rb <="1111";
RegWr <='1';
AluCtr <= "00"; -- S = A + B
ALUsrc <= '0';
WrSrc <= '0';
MemWr <= '0';
wait for 20 ns;

-- R(3) = R(1) + Imm(15) = 63
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

-- R(4) = R(5) - R(15) = -48
Ra<= "0101"; -- busA = R(1) 
Rw<="0100"; 
Rb <="1111"; 
RegWr <='1'; 
AluCtr <= "10"; -- S = A - B
ALUsrc <= '0'; 
WrSrc <= '0'; 
MemWr <= '0'; 
wait for 20 ns;

-- R(5) = R(1) - Imm (16) = 32
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

-- Mem(R1) = R(3) = 63
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

-- R(6) = Mem(R1) = 63
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

OUI <= True; 
wait;

end process;
end architecture;