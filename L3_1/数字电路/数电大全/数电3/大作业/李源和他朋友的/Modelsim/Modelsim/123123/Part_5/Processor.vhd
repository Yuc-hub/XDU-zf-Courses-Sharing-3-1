-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com
-- Date : 28/05/2022

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is
port (clk, rst : in  std_logic);
end entity;

architecture BEHAVIOUR of Processor is

signal nPCSel, MemWr, RegWr, ALUsrc, WrSrc, RegSel, PSREn : std_logic ;
signal ALUctr : std_logic_vector(1 downto 0);
signal offset : std_logic_vector(23 downto 0);
signal Imm : std_logic_vector(7 downto 0);
signal Instruction, PSR : std_logic_vector(31 downto 0);
signal Rn, Rd, Rm : std_logic_vector(3 downto 0);

begin

U1 : entity work.FinalTreatU port map(
Clk => clk, rst => rst, Rn => Rn, Rd => Rd, Rm => Rm, RegWr => RegWr,
PSR => PSR, Imm => Imm, ALUctr => ALUctr, MemWr => MemWr, ALUSrc => ALUSrc,
WrSrc => WrSrc, RegSel => RegSel, PSREn => PSREn);

U2 : entity work.InstructionU port map(
Clk => clk, rst => rst, nPCSel=> nPCSel,
Instruction => Instruction, offset => offset);

U3 : entity work.Decoder port map(
Rn => Rn, Rd => Rd, Rm=> Rm, RegWr=> RegWr,
PSR => PSR, Imm => Imm, ALUctr=> ALUctr, MemWr => MemWr, ALUSrc => ALUSrc,
WrSrc => WrSrc,PSREn => PSREn, nPCSel => nPCSel, RegSel => RegSel, 
Instruction => Instruction, offset => offset);

end architecture;