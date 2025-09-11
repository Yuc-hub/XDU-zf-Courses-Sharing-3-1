LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity ALU is 
port (
			N : out  std_logic ; 
			S : out std_logic_vector(31 downto 0);
			A, B : in std_logic_vector(31 downto 0);
			OP : in std_logic_vector(1 downto 0)
			
		);
end entity;

architecture BEHAVIOUR of ALU is
signal Si : std_logic_vector(31 downto 0); 
begin

process(A,B,OP)
begin 
	case OP is 
		when "00" => Si <= std_logic_vector(signed(A)+signed(B)); 
		when "01" => Si <= B; 
		when "10" => Si <= std_logic_vector(signed(A)-signed(B));
		when "11" => Si <= A; 
		when others => Si <= A; 
	end case; 	
end process; 

N <= Si(31); -- bit de signe, '1' -> negatif, '0' -> positif
S <= Si; 
end architecture;
