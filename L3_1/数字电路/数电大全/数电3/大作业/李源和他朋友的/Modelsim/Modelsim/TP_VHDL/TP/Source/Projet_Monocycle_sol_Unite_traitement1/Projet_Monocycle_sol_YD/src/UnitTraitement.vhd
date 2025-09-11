LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity UnitTraitement is 
port (
			clk, rst, WE : in  std_logic ; 
			Ra, Rb, Rw : in std_logic_vector(3 downto 0);
			W : out std_logic_vector(31 downto 0);
			N : out std_logic; 
			OP : in std_logic_vector(1 downto 0)
		);
end entity;

architecture BEHAVIOUR of UnitTraitement is
signal busA,busB, busW : std_logic_vector(31 downto 0);

begin

U1 : entity work.BancRegistre port map(
Clk => clk, rst => rst, WE=> We, Ra => Ra, Rb => Rb, Rw => Rw, 
A => busA, B => busB, W=> busW); 

U2 : entity work.ALU port map(
A => busA, B=> busB, S => busW, OP => OP, N => N); 

W <= busw; 


end architecture;
