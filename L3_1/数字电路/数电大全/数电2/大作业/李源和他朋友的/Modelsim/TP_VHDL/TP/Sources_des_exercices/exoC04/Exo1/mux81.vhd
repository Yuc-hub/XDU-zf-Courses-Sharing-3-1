LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity MUX81 IS
	port(
		I 	: in std_logic_vector(7 downto 0);
		Y 	: out std_logic;
		SEL: in std_logic_vector(2 downto 0));
END MUX81 ;


architecture RTL of MUX81 is

begin
	
end architecture;