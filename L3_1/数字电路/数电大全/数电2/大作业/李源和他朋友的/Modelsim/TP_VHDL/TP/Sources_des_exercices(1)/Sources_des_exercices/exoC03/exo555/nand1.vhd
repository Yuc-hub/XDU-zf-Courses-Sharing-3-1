LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity nand1 is 
port (	A, B: in std_logic;
	C: out  std_logic 
	);
end entity;

architecture art of nand1 is
begin
	
	C<= (A nand B);

end architecture;
