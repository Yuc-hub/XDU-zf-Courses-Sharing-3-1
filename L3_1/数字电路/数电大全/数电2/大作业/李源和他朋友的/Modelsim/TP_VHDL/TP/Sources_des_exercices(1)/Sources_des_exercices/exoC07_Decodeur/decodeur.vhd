-- Squelette pour l'exercice Decodeur

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity decodeur is
  port (I : in  Std_logic_vector(5 downto 0);
        EN: in  Std_logic;
        Y : out Std_logic_vector(63 downto 0));
end entity;

architecture rtl of decodeur is
begin

--process(all)
process(en,I)
begin
  Y <= (others => '0'); -- par defaut
--  if en = '1' then
--	Y(to_integer(unsigned(I))) <= '1';
--  end if;
  Y(to_integer(unsigned(I))) <= EN;
end process;
end architecture rtl;