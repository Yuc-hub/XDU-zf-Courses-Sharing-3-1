LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Registre is
port (  clk, rst, WE : in  std_logic;
	DATAIN : in std_logic_vector(31 downto 0);
	DATAOUT : out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behaviour of Registre is
begin

process(clk, rst)
begin
if rst ='1' then
	DATAOUT <= (others => '0');
elsif rising_edge(clk) then
	if WE = '1' then
		DATAOUT <= DATAIN;
	end if;
end if;
end process;

end architecture;
