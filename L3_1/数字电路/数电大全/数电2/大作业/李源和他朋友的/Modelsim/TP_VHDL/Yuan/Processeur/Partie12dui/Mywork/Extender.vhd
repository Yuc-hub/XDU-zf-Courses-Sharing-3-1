LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Extender is
generic (N : positive := 8);
port (  E : in std_logic_vector(N-1 downto 0); -- bus de N bits en entree
	S : out std_logic_vector(31 downto 0) -- bus de 32 bits en sortie
	);
end entity;


architecture BEHAVIOUR of Extender is
begin

process(E)
begin
	S(N-1 downto 0) <= E;
	S(31 downto N) <= (others => E(N-1)); -- extension la signe
end process;

end architecture;
