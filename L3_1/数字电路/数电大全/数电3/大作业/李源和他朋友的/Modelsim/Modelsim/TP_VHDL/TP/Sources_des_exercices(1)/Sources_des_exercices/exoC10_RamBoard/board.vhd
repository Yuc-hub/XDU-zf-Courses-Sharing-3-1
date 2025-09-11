-- Auteur: Yuan Li
-- Numero: 19022100022
-- Date: 11/avril/2022

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity Board is
  port (Address: in Std_logic_vector(7 downto 0);
        Data: inout Std_logic_vector(15 downto 0);
        nWE, nOE: in Std_logic);
end entity Board;

architecture Struct of Board is
   signal PoidsFort,PoidsFaible : Std_logic_vector(3 downto 0);
   signal Decode : Std_logic_vector(15 downto 0);
begin
   PoidsFort <= Address(7 downto 4); -- 4 bits de poids fort
   PoidsFaible <= Address(3 downto 0); -- 4 bits de poids faible

-- Decodeur
   Decode <= (others => '0');
   Decode(to_integer(unsigned(PoidsFort))) <= '1';

-- Instanciation d'un composant generique
L1: for I in 0 to 15 generate
	U1 : entity work.ramchip generic map(4, 16)
        port map(nCS => Decode(I), -- Chip selects
                 Address => PoidsFaible,
                 nWE => nWE,
                 nOE => nOE,
                 Data => Data); -- association par nom
end generate;
end architecture Struct;