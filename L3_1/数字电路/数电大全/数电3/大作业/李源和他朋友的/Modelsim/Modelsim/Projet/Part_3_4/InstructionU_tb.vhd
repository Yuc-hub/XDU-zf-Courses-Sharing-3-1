-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionU_tb is
end entity;

architecture BENCH of InstructionU_tb is

	signal Instruction :  std_logic_vector(31 downto 0);
	signal Clk  :  std_logic := '0';
	signal rst, nPCsel :  std_logic;
	signal Offset : std_logic_vector(23 downto 0);
	signal OUI : boolean := False;

begin

	UUT : entity work.InstructionU port map(
	clk=>clk, rst=> rst, nPCsel =>nPCsel, Offset => Offset,
	Instruction => Instruction);

	CLK <= '0' when OUI else not CLK after 10 NS;
	Rst <= '1', '0' after 2 ns;

process
begin
-- PC <= PC + 1 = 1
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;

-- PC <= PC + 1 = 2
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;

-- PC <= PC + 1 = 3
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;

-- PC <= PC + 1 + Offset of 5 = 9
nPCsel<= '1'; 
Offset <= x"000005"; 
wait for 20 ns;

-- PC <= PC + 1 Offset of 1 = B
nPCsel<= '1'; 
Offset <= x"000001"; 
wait for 20 ns;

-- PC <= PC + 1 + Offset of -4 = 8
nPCsel<= '1'; 
Offset <= x"FFFFFC"; 
wait for 20 ns;

-- PC <= PC + 1 = 9
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;

OUI <= True; 
wait;

end process;

end architecture;