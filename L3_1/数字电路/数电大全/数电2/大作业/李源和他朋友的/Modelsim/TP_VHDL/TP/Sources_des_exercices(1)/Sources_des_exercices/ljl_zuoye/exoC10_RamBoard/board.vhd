-- Junliang Liu
-- 19022100059

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity Board is
  port (Address: in Std_logic_vector(7 downto 0);
        Data: inout Std_logic_vector(15 downto 0);
        nWE, nOE: in Std_logic);
end entity Board;

architecture Struct of Board is
   signal A : Std_logic_vector(3 downto 0);
   signal B : Std_logic_vector(3 downto 0);
   signal C : Std_logic_vector(15 downto 0);
begin
   C <= (others => '0');
   C(to_integer(unsigned(A))) <= '1';
   A <= Address(7 downto 4);
   B <= Address(3 downto 0);
A1: for I in 0 to 15 generate
	B1 : entity work.ramchip generic map(4, 16)
        port map(nCS => C(I), Address => B, nWE => nWE, nOE => nOE, Data => Data);
end generate;
end architecture Struct;
