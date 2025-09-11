-- Boyuan Wang
-- 19022100004

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity Board is
  port (Address: in Std_logic_vector(7 downto 0);
        Data: inout Std_logic_vector(15 downto 0);
        nWE, nOE: in Std_logic);
end entity Board;

architecture Struct of Board is
   signal I : Std_logic_vector(3 downto 0);
   signal Addr : Std_logic_vector(3 downto 0);
   signal Y : Std_logic_vector(15 downto 0);
begin
   	Y <= (others => '0');
   	Y(to_integer(unsigned(I))) <= '1';
   	I <= Address(7 downto 4);
   	Addr <= Address(3 downto 0);
A1: for I in 0 to 15 generate
	B1 : entity work.ramchip generic map(4, 16)
        port map(nCS => Y(I), Address => Addr, nWE => nWE, nOE => nOE, Data => Data);
end generate;
end architecture Struct;
