-- Squelette pour l'exercice Decodeur

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity DECODEUR is
  port (I : in  Std_logic_vector(5 downto 0);
        EN: in  Std_logic;
        Y : out Std_logic_vector(63 downto 0));
end entity;

architecture RTL of DECODEUR is
begin
  process(EN,I)
  begin
    Y <= std_logic_vector(to_unsigned(0,64));
	--Y <= (others => '0');
    Y(to_integer(unsigned(I))) <= EN;
   
  end process;
          
  
end architecture RTL;
