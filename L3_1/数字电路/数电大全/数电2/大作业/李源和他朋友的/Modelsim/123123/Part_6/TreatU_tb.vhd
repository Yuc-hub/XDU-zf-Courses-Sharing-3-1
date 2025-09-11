-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com
-- Date : 28/05/2022

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TreatU_tb is
end entity ;

architecture BENCH of TreatU_tb is

	signal Ra,Rb,Rw : std_logic_vector(3 downto 0);
	signal AluCtr :  std_logic_vector(1 downto 0);
	signal W :  std_logic_vector(31 downto 0);
	signal clk  :  std_logic := '0';
	signal rst, RegWr, MemWr, ALUsrc, WrSrc, N :  std_logic;
	signal Imm : std_logic_vector(7 downto 0);
	signal OUI : boolean := False; 
	
begin

UUT : entity work.TreatU port map(
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
ALUctr <= "11"; -- ALUout = S = busA
WrSrc <= '0'; -- busW = S = ALUout
RegWr <='1'; -- write
Rw <= "0001"; -- R(1) <= bus W
MemWr <= '0'; -- non
wait for 20 ns;

-- R(2) = R(1) + R(15) = 96
Ra <= "0001"; -- busA = R(1) 
Rb <= "1111"; -- busB = R(15)
Imm <= "00000000"; -- par defaut
ALUsrc <= '0'; -- select busA
ALUctr <= "00"; -- ALUout = S = A + B
WrSrc <= '0';  -- busW = S = ALUout
RegWr <='1'; -- write
Rw<="0010"; -- R(2) <= bus W
MemWr <= '0'; -- non
wait for 20 ns;

-- R(3) = R(1) + Imm(15) = 56
Ra <= "0001"; -- busA = R(1) 
Rb <= "0000"; -- par defaut
Imm <= "00001000"; -- Imm = 8
ALUsrc <= '1'; -- select busB
ALUctr <= "00"; -- ALUout = S = A + B
WrSrc <= '0';  -- busW = S = ALUout
Rw <= "0011"; -- R(3) <= bus W
RegWr <='1'; -- write
MemWr <= '0'; -- non
wait for 20 ns;

-- R(4) = R(1) - R(2) = -48
Ra <= "0001"; -- busA = R(1)
Rb <= "0010"; -- busB = R(2)
Imm <= "00000000"; -- par defaut
ALUsrc <= '0'; -- select busA
ALUctr <= "10"; -- S = A - B
WrSrc <= '0'; -- write
Rw <= "0100"; -- R(4) <= bus W
RegWr <='1'; 
MemWr <= '0'; 
wait for 20 ns;

-- R(5) = R(1) - Imm (2) = 46
Ra <= "0001"; -- busA = R(1)
Rb <= "0000"; -- par defaut
Imm <= "00000010"; -- Imm = 2
ALUsrc <= '1'; 
AlUctr <= "10"; -- S = A - B
WrSrc <= '0'; 
Rw <= "0101";  -- R(5) <= bus W
RegWr <='1'; 
MemWr <= '0'; 
wait for 20 ns;

-- R(6) = R(1) = 48
Ra <= "0001"; -- busA = R(1)
Rb <= "0000"; -- par defaut
Imm <= "00000000"; -- par defaut
ALUsrc <= '0'; -- select busB
ALUctr <= "11"; -- ALUout = S = busA
WrSrc <= '0'; -- busW = S = ALUout
RegWr <='1'; -- write
Rw <= "0110"; -- R(6) <= bus W
MemWr <= '0'; -- non
wait for 20 ns;

-- Mem(R1) = R(3) = 56
Ra<= "0001"; -- Addr = R(1) 
Rb <="0011"; --R(3)
Imm <= "00000000"; -- par defaut
ALUctr <= "11"; -- S = A
ALUsrc <= '0';
Rw<="0000"; -- par defaut
WrSrc <= '0';
RegWr <= '0'; -- no
MemWr <= '1'; -- write memory
wait for 20 ns;

-- R(6) = Mem(R1) = 56
Ra<= "0001"; -- par defaut
Rb <= "0000"; -- par defaut
Imm <= "00000000"; -- par defaut
Rw<="0110"; --R(6) 
RegWr <='1'; 
ALUctr <= "11"; -- S = A
ALUsrc <= '0';
WrSrc <= '1'; -- S = Dataout
MemWr <= '0';
wait for 20 ns;

OUI <= True; 
wait;

end process;
end architecture;