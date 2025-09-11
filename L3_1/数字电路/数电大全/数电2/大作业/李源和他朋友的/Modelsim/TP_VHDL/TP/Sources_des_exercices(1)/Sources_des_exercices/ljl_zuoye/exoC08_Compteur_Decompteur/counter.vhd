-- Junliang Liu 
-- 19022100059
-- Squelette pour l'exercice Compteur
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_std.all;

entity Counter is
  port (Clock, Reset, Enable, Load, UpDn: in Std_logic;
        Data: in Std_logic_vector(7 downto 0);
        Q:   out Std_logic_vector(7 downto 0));
end entity Counter;


-- Première partie
architecture RTL of Counter is
signal cpt : unsigned(7 downto 0);
begin
process(clock, reset)
begin
if reset = '1' then
	cpt <= "00000000";
elsif rising_edge(clock) then
	if enable = '1' then
		if load = '1' then
			cpt <= unsigned(data);
		elsif updn = '1' then
			cpt <= cpt + 1;
		elsif updn = '0' then
			cpt <= cpt - 1;
		end if;
	end if;
end if;
end process;
Q <= std_logic_vector(cpt);
end architecture;



-- Deuxième partie
architecture RTL2 of Counter is
signal cpt : unsigned(7 downto 0);
begin
process(clock)
begin
if rising_edge(clock) then
	if reset = '1' then
		cpt <= "00000000";
	elsif enable = '1' then
		if load = '1' then
			cpt <= unsigned(data);
		elsif updn = '1' then
			cpt <= cpt + 1;
		elsif updn = '0' then
			cpt <= cpt - 1;
		end if;
	end if;
end if;
end process;
Q <= std_logic_vector(cpt);
end architecture;





-- Troisième partie
architecture RingCounter of Counter is
signal cpt : unsigned(7 downto 0);
begin
process(clock)
begin
if rising_edge(clock) then
	if reset = '1' then
		cpt <= (others => '0');
	elsif enable = '1' then
		if load = '1' then
			cpt <= unsigned(data);
		elsif updn = '1' then
			if cpt = "00000000" or cpt = "10000000" then
				cpt <= "00000001";
			else
				cpt <= cpt sll 1;
			end if;
		elsif updn = '0' then
			if cpt = "00000000" or cpt = "00000001" then
				cpt <= "00000001";
			else
				cpt <= cpt srl 1;
			end if;
		end if;
	end if;
end if;
end process;
Q <= std_logic_vector(cpt);
end architecture;