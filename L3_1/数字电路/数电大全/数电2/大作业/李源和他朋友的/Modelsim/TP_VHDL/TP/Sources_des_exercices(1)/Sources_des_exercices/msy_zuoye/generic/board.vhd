-- Squelette pour l'exercice carte mémoire

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity Board is

generic (
         BoardAddressSize : integer;
         ChipAddressSize : integer;
         WordSize : integer);

port (Address: in Std_logic_vector(BoardAddressSize-1 downto 0);
        Data: inout Std_logic_vector(WordSize-1 downto 0);
        nWE, nOE: in Std_logic);
end entity Board;


architecture Struct of Board is
signal A : Std_logic_vector(BoardAddressSize-ChipAddressSize-1 downto 0);
signal B : Std_logic_vector(ChipAddressSize-1 downto 0);
signal C : Std_logic_vector(2**(BoardAddressSize-ChipAddressSize)-1 downto 0);
begin
A <= Address(BoardAddressSize-1 downto ChipAddressSize);
B <= Address(ChipAddressSize-1 downto 0);
C <= (others => '0');
C(to_integer(unsigned(A))) <= '1';
M1: for I in 0 to 2**(BoardAddressSize-ChipAddressSize)-1 generate
	S1 : entity work.ramchip generic map(4, 16)
        port map(nCS => C(I), Address => B, nWE => nWE, nOE => nOE, Data => Data);
end generate;
end architecture Struct;
