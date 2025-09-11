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
process (I, SEL)
begin
	case(SEL) is
		when x"0" => Y <= I(0);
		when x"1" => Y <= I(1);
		when x"2" => Y <= I(2);
		when x"3" => Y <= I(3);
		when x"4" => Y <= I(4);
		when x"5" => Y <= I(5);
		when x"6" => Y <= I(6);
		when others => Y <= I(7);
	end case;
end process;
end architecture;
	
end architecture;