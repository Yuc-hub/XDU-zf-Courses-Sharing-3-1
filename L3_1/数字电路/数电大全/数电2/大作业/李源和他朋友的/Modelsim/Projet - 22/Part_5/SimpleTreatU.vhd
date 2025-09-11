-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SimpleTreatU is
port (  clk, rst, WE : in  std_logic ;
	Ra, Rb, Rw : in std_logic_vector(3 downto 0);
	OP : in std_logic_vector(1 downto 0);
	W : out std_logic_vector(31 downto 0);
	N : out std_logic
	);
end entity;

architecture BEHAVIOUR of SimpleTreatU is
signal busA,busB, busW : std_logic_vector(31 downto 0);

begin

U1 : entity work.RegisterBank port map(
clk => clk, rst => rst, WE=> We,
Ra => Ra, Rb => Rb, Rw => Rw,
A => busA, B => busB, W=> busW);

U2 : entity work.ALU port map(
A => busA, B=> busB,
S => busW, OP => OP, N => N);

W <= busW;

end architecture;
