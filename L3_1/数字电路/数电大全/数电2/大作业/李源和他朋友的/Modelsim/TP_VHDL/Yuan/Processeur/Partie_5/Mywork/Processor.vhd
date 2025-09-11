LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Processor is
port (  clk, rst : in  std_logic
	);
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
Clk => clk, rst => rst, RegWr=> RegWr, Rn => Rn, Rd => Rd, Rm=> Rm,
PSR => PSR, Imm => Imm, ALUctr=> ALUctr, MemWr=> MemWr, ALUSrc=> ALUSrc,
WrSrc=> WrSrc, RegSel=> RegSel, PSREn => PSREn);

U2 : entity work.InstructionU port map(
Clk => clk, rst => rst, nPCSel=> nPCSel,
Instruction=> Instruction, offset => offset);

U3 : entity work.Decoder port map(
RegWr=> RegWr, Rn => Rn, Rd => Rd, Rm=> Rm,
PSR => PSR, Imm => Imm, ALUctr=> ALUctr, MemWr=> MemWr, ALUSrc=> ALUSrc,
WrSrc=> WrSrc, RegSel=> RegSel, PSREn => PSREn, nPCSel=> nPCSel,
Instruction=> Instruction, offset=> offset);

end architecture;