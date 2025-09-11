-- Squelette pour l'exercice Compteur
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_std.all;

entity Counter is
  port (Clock, Reset, Enable, Load, UpDn: in Std_logic;
        Data: in Std_logic_vector(7 downto 0);
        Q:   out Std_logic_vector(7 downto 0));
end entity Counter;

architecture RTL of Counter is
  signal count : unsigned(7 downto 0);
begin
  process(reset, Clock)
  begin
    if reset = '1' then
      count <= "00000000";
    elsif rising_edge(Clock) then
      if Enable = '1' then
        if Load = '1' then
          count <= unsigned(Data);
        elsif UpDn = '1' then
          count <= count + 1;
        elsif upDn = '0' then
          count <= count - 1;
        end if;
      end if;
    end if;
  end process;
  Q <= std_logic_vector(count);
end architecture RTL;

-- si il vous reste du temps:
-- process avec un reset synchrone
architecture RTL2 of Counter is
  signal count : unsigned(7 downto 0);
begin
  process(Clock)
  begin
    if rising_edge(Clock) then
      if reset = '1' then
            count <= "00000000";
      elsif Enable = '1' then
        if Load = '1' then
          count <= unsigned(Data);
        elsif UpDn = '1' then
          count <= count + 1;
        elsif upDn = '0' then
          count <= count - 1;
        end if;
      end if;
    end if;
  end process;
  Q <= std_logic_vector(count);
end architecture RTL2;

-- si il vous reste encore du temps!
-- compteur en anneau: ringcounter

architecture RTL3 of Counter is
  signal count : unsigned(7 downto 0);
begin
  process(reset, Clock)
  begin
    if reset = '1' then
       count <= "00000000";
    elsif rising_edge(Clock) then
      if Enable = '1' then
        if Load = '1' then
          count <= unsigned(Data);
        elsif UpDn = '1' then
          if count = "00000000" or count = "10000000" then 
            count <= "00000001";
          else
            count <= count(6 downto 0) & '0';
          end if;
        elsif upDn = '0' then
          if count = "00000000" or count = "00000001" then 
            count <= "10000000";
          else
            count <= '0' & count(7 downto 1);
          end if;
        end if;
      end if;
    end if;
  end process;
  Q <= std_logic_vector(count);
end architecture RTL3;

