-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com
-- Date : 28/05/2022

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory is
port (  clk, rst, WrEn : in  std_logic;
	Addr : in std_logic_vector(5 downto 0);
	DataIn : in std_logic_vector(31 downto 0);
	DataOut : out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behavior of DataMemory is

-- Creer tableau
type table is array(63 downto 0) of std_logic_vector(31 downto 0);
signal mem : table;

begin

-- L'ecriture synchrone
process(clk, rst) 
begin 
if rst ='1' then 
	for i in 63 downto 0 loop
		mem(i) <= std_logic_vector(to_unsigned(i,32)); -- mem(0) = 0, mem(1) = 1...
	end loop;
elsif rising_edge(clk) then 
	if WrEn = '1' then 
		mem(to_integer(unsigned(Addr))) <= DataIn; 
	end if; 
end if; 
end process; 

-- La lecture combinatoire et simultanee
DataOut <= mem(to_integer(unsigned(Addr)));

end architecture;
