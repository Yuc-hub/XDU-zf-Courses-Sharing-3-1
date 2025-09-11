-- Auteur: Yuan Li
-- Numero: 19022100022
-- Date: 11/avril/2022

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RamChip is
  generic (
           AddressSize : integer;
           WordSize : integer);
--           AddressSize : integer := 4;
--           WordSize : integer := 16);
  port (Address: in Std_logic_vector(AddressSize-1 downto 0);
        Data: inout Std_logic_vector(WordSize-1 downto 0);
        nCS, nWE, nOE: in Std_logic);
end entity;

architecture Behaviour of RamChip is
   type ram is array (0 to 2**AddressSize-1) of Std_logic_vector(WordSize-1 downto 0);
-- 2**AddressSize-1
   signal mem : ram;
begin
  process(nCS,nWE,nOE,Address,Data)
  begin
    Data <= (others => 'Z');
    if (nCS ='0') then
      if (nWE = '0') then
        mem(to_integer(unsigned(Address))) <= Data;
      end if;
      if (nOE = '0') then
        Data <= mem(to_integer(unsigned(Address)));
      end if;
    end if;      
  end process;
end architecture;
