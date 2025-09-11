-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SimpleTreatU_tb is
end entity;

architecture BENCH of SimpleTreatU_tb is
	signal rst, WE, N : std_logic;
	signal Ra,Rb,Rw : std_logic_vector(3 downto 0);
	signal OP : std_logic_vector(1 downto 0);
	signal W : std_logic_vector(31 downto 0);
	signal clk : std_logic := '0';
	signal OUI : boolean := false;

begin

UUT : entity work.SimpleTreatU port map(
	Ra => Ra, Rb=> Rb, Rw => Rw,
	clk=>clk, rst=> rst, WE =>WE,
	N => N, W=>W, OP => OP); 

-- Generation d'une horloge
clk <= '0' when OUI 
	   else not CLK after 10 NS;

-- Generation d'un reset
Stimulus: process
begin
	rst <= '1';
	wait for 2 NS;
	rst <= '0';
	wait;
end process Stimulus;

process
begin

-- R(1) = R(15) = X"00000030"
Ra<= "1111"; -- A = R(15)
Rb <="0000"; -- par default
OP <= "11"; -- Y = A
WE <='1'; -- write enable
Rw<="0001"; -- R(1) <= W
wait for 20 ns;

-- R(1) = R(1) + R(15) = X"00000060"
Ra<= "0001"; -- A = R(1)
Rb <="1111"; -- B = R(15)
OP <= "00"; -- Y = A + B
WE <='1'; -- write enable
Rw<="0001"; -- R(1) <= W
wait for 20 ns;

-- R(2) = R(1) + R(15) = X"00000090"
Ra<= "0001"; -- A = R(1)
Rb <="1111"; -- B = R(15)
OP <= "00"; -- Y = A + B
WE <='1'; -- write enable
Rw<="0010"; -- R(2) <= W
wait for 20 ns;

-- R(3) = R(1) - R(15)= X"00000030"
Ra<= "0001"; -- A = R(1)
Rb <="1111"; -- B = R(15)
OP <= "10"; -- Y = A - B
WE <='1'; -- write enable
Rw<="0011"; -- R(2) <= W
wait for 20 ns;

-- R(5) = R(7) - R(15)= X"FFFFFFD0"
Ra<= "0111"; -- A = R(7)
Rb <="1111"; -- B = R(15)
OP <= "10"; -- Y = A - B
WE <='1'; -- write enable
Rw<="0101"; -- R(2) <= W
wait for 20 ns;

OUI <= True;
wait;

end process;
end architecture;