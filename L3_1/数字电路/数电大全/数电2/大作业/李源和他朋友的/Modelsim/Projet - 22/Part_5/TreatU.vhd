-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TreatU is
port (  clk, rst, MemWr, RegWr, ALUsrc, WrSrc : in  std_logic;
	Ra, Rb, Rw : in std_logic_vector(3 downto 0);
	ALUctr : in std_logic_vector(1 downto 0);
	Imm : in std_logic_vector(7 downto 0);
	N : out std_logic;
	W : out std_logic_vector(31 downto 0)
	);
end entity;

architecture BEHAVIOUR of TreatU is
signal busA,busB,ALUout,busExt,busMux, busW : std_logic_vector(31 downto 0);
signal DataOut : std_logic_vector(31 downto 0);
begin

U1 : entity work.RegisterBank port map(
	clk => clk, rst => rst, WE => RegWr,
	Rw => Rw, Ra => Ra, Rb => Rb,
	A => busA, B => busB, W=> busW);

U2 : entity work.ALU port map(
	A => busA, B=> busMux, OP => ALUctr,
	S => ALUout, N => N);

U3 : entity work.Extender port map(
	E => Imm, S => busExt);

U4 : entity work.MUX2to1 port map(
	A => busB, B=> busEXT,
	S=> busMux, COM => ALUsrc);

U5 : entity work.MUX2to1 port map(
	A => ALUout, B=> DataOut,
	S=> busW, COM => WrSrc);

U6 : entity work.DataMemory port map(
	clk => clk, rst => rst,
	Addr => ALUOut(5 downto 0),
	WrEn => MemWr, DataIn => busB,
	DataOut => DataOut);

W <= busW;

end architecture;
