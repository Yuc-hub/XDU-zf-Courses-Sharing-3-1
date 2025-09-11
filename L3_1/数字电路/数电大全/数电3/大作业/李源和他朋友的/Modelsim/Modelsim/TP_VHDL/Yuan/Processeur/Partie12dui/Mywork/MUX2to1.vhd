LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity MUX2to1 is
generic (N : integer := 32);
port (  A, B : in std_logic_vector(N-1 downto 0); -- deux bus entree
	COM : in std_logic; -- commande de selection
	S : out std_logic_vector(N-1 downto 0) -- bus sortie
	);
end entity;

architecture Behaviour of MUX2to1 is
begin

process(A,B,COM)
begin
	if COM = '0' then S <= A;
	elsif COM='1' then S <= B;
	end if;
end process;

end architecture;
