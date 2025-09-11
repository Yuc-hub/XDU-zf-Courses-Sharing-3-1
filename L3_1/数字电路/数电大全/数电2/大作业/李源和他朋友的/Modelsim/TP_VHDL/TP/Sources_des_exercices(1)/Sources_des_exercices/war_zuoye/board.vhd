-- Squelette pour l'exercice carte mémoire

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity Board is
  port (Address: in Std_logic_vector(7 downto 0);
        Data: inout Std_logic_vector(15 downto 0);
        nWE, nOE: in Std_logic);
end entity Board;

architecture Struct of Board is
   signal A,B : Std_logic_vector(3 downto 0);
   signal C : Std_logic_vector(15 downto 0);
begin
   A <= Address(7 downto 4);
   B <= Address(3 downto 0);
C <= (others => '0');
C(to_integer(unsigned(A))) <= '1';

L1: for I in 0 to 15 generate
	U1 : entity work.ramchip generic map(4, 16)
        port map(nCS => C(I), Address => B, nWE => nWE, nOE => nOE, Data => Data);
end generate;
end architecture Struct;
