library IEEE;
use IEEE.std_logic_1164.all;

entity RamChip_tb is  
end;

architecture Bench of Ramchip_tb is
  signal Address: Std_logic_vector(3 downto 0);
  signal Data: Std_logic_vector(7 downto 0);
  signal nCS, nWE, nOE: Std_logic;
  constant delay : time := 10 ns;
begin
 UUT:entity  work.ramchip port map (
				Address => Address, 
				data => data,
				nCS => nCS, nWE => nWE, nOE => nOE);
  process
  begin
  -- initialisation
  nOE <='1';
  nWE <='1';
  nCS <= '1';
  Address <= "0000";
  Data <= "ZZZZZZZZ"; 
  wait for delay;
  
  -- ecriture en 0
  Address <= "0000";
  Data <= "01010101"; 
  nCS <= '0';
  wait for delay;
  nWE <= '0';  
  wait for delay;
  nWE <= '1'; 
  wait for delay;
  nCS <= '1';
  wait for delay;

  -- ecriture en 9 
  Address <= "1001";
  Data <= "00001111"; 
  nCS <= '0';
  wait for delay;
  nWE <= '0';  
  wait for delay;
  nWE <= '1'; 
  wait for delay;
  nCS <= '1';
  
  -- lecture en 0
  Address <= "0000";
  data <= (others => 'Z');
  wait for delay;
  nCS <= '0';
  wait for delay;
  nOE <= '0';
  wait for delay;
  nOE <='1';
  wait for delay;
  nCS <='1';
  
  -- lecture en 9
  Address <= "1001";
  data <= (others => 'Z');
  wait for delay;
  nCS <= '0';
  wait for delay;
  nOE <= '0';
  wait for delay;
  nOE <='1';
  wait for delay;
  nCS <='1';
  wait for delay;
  
--  -- conflit de bus
--  nCS <= '0';
--  Data <= "HL10HL10"; 
--  wait for delay;
--  nOE <= '0';  
--  wait for delay;
--  nOE <= '1'; 
--  wait for delay;
--  nCS <= '1';
--
  
  wait;  -- arreter la simulation
  
  
  end process;
  
 
end;

