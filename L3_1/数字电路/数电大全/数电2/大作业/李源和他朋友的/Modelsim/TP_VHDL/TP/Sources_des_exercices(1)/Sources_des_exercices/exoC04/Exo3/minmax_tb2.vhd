----------- Squelette du Banc de Test pour l'exercice MinMax -------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MinMax_TB is
 port( OK: out boolean:=TRUE);
end entity MinMax_TB;

architecture BENCH of MinMax_TB is
  signal Tmin0max1: std_logic;
  signal TX,TY,TZ : std_logic_vector(3 downto 0);
begin
  UUT : entity work.minmax port map (
	X => TX, Y =>TY, Z => TZ, Min0Max1 => Tmin0max1);
process
  begin
	Tmin0max1 <= '0';
	TX <= x"0"; TY <= x"0";
	wait for 10 ns;	
	OK <= TZ = x"0";
	assert TZ = x"0" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '1';
	TX <= x"0"; TY <= x"0";
	wait for 10 ns;	
	OK <= TZ = x"0";
	assert TZ = x"0" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '1';
	TX <= x"1"; TY <= x"0";
	wait for 10 ns;	
	OK <= TZ = x"1";
	assert TZ = x"1" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '0';
	TX <= x"1"; TY <= x"0";
	wait for 10 ns;	
	OK <= TZ = x"0";
	assert TZ = x"0" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '0';
	TX <= x"1"; TY <= x"2";
	wait for 10 ns;	
	OK <= TZ = x"1";
	assert TZ = x"1" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '1';
	TX <= x"1"; TY <= x"2";
	wait for 10 ns;	
	OK <= TZ = x"2";
	assert TZ = x"2" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '1';
	TX <= x"5"; TY <= x"2";
	wait for 10 ns;	
	OK <= TZ = x"5";
	assert TZ = x"5" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '0';
	TX <= x"5"; TY <= x"2";
	wait for 10 ns;	
	OK <= TZ = x"2";
	assert TZ = x"2" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '0';
	TX <= x"5"; TY <= x"A";
	wait for 10 ns;	
	OK <= TZ = x"5";
	assert TZ = x"5" report "erreur" severity warning;
	wait for 10 ns;

	Tmin0max1 <= '1';
	TX <= x"5"; TY <= x"A";
	wait for 10 ns;	
	OK <= TZ = x"A";
	assert TZ = x"A" report "erreur" severity warning;
	wait for 10 ns;
  wait;
  end process;
end architecture BENCH;
