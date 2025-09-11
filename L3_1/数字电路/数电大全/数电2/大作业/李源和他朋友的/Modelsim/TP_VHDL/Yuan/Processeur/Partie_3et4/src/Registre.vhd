LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity Registre is 
port (
			clk, rst, WE : in  std_logic ; 
			DataOut : out std_logic_vector(31 downto 0);
			DataIn : in std_logic_vector(31 downto 0)
		);
end entity;

architecture BEHAVIOUR of Registre is

begin




process(clk, rst) 
begin 
if rst ='1' then 
	DataOut <= (others => '0'); 
elsif rising_edge(clk) then 
	if WE = '1' then 
		DataOut <= DataIn;	
	end if; 
end if; 
end process; 


end architecture;
