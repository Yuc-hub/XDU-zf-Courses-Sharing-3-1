-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com
-- Date : 28/05/2022

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is 
port (  OP : in std_logic_vector(1 downto 0); -- OP: Signal de commande
	A, B : in std_logic_vector(31 downto 0); -- bus en entree
	S : out std_logic_vector(31 downto 0); -- bus en sortie
	N : out  std_logic -- drapeau de sortie
	);
end entity;

architecture Behaviour of ALU is

signal Y : std_logic_vector(31 downto 0);

begin

process(A,B,OP)
begin
	case OP is
	when "00" => Y <= std_logic_vector(signed(A)+signed(B));
	when "01" => Y <= B;
	when "10" => Y <= std_logic_vector(signed(A)-signed(B));
	when "11" => Y <= A;
	when others => Y <= A;
	end case;
end process;

N <= Y(31); -- 31 est le bit de signe N. Si negatif N = 1, sinon N = 0
S <= Y;

end architecture;
