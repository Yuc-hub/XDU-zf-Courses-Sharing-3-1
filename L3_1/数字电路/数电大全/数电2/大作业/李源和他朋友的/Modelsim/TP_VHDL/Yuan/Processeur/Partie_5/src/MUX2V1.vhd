LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity MUX2V1 is 
generic (N : positive :=32);
port (
			
			S : out std_logic_vector(N-1 downto 0);
			A, B : in std_logic_vector(N-1 downto 0);
			COM : in std_logic
			
		);
end entity;

architecture BEHAVIOUR of MUX2V1 is

begin

process(A,B,COM)
begin 
	if COM = '0' then S <= A; 
	elsif COM='1' then S <= B; 
	end if; 
end process; 

end architecture;
