LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity BancRegistre is 
port (
			clk, rst, WE : in  std_logic ; 
			Ra, Rb, Rw : in std_logic_vector(3 downto 0);
			A, B : out std_logic_vector(31 downto 0);
			W : in std_logic_vector(31 downto 0)
		);
end entity;

architecture BEHAVIOUR of BancRegistre is
-- Declaration Type Tableau Memoire
type table is array(15 downto 0) of std_logic_vector(31 downto 0);
-- Fonction d'Initialisation du Banc de Registres
function init_banc return table is
variable result : table;
begin
	for i in 14 downto 0 loop
		result(i) := (others=>'0');
	end loop;
		result(15):=X"00000030";
	return result;
end init_banc;
-- Déclaration et Initialisation du Banc de Registres 16x32 bits
signal Banc: table:=init_banc;

begin

A <= Banc(to_integer(unsigned(Ra))); 
B <= Banc(to_integer(unsigned(Rb))); 

process(clk, rst) 
begin 
if rst ='1' then 
	for i in 14 downto 0 loop
		Banc(i) <= (others=>'0');
	end loop;
		Banc(15)<=X"00000030";
	
elsif rising_edge(clk) then 
	if WE = '1' then 
		Banc(to_integer(unsigned(Rw)))<=W; 
	end if; 
end if; 
end process; 


end architecture;
