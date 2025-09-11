-- Processeur Mono-Cycle
-- Author : Yuan Li - 19022100022
-- Mail : 16663781008@163.com
-- Date : 28/05/2022

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder is 
port (  Instruction, PSR : in std_logic_vector(31 downto 0);
		nPCSel, RegWr, MeMWr, ALUSrc, PSREn, WrSrc, RegSel  : out std_logic;
		ALUCtr : out std_logic_vector(1 downto 0);
		Rn, Rd, Rm : out std_logic_vector(3 downto 0);
		Imm : out std_logic_vector(7 downto 0);
		Offset : out std_logic_vector(23 downto 0)
		);
end entity;

architecture Behaviour of Decoder is

type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
signal instr_courante: enum_instruction;
signal N : std_logic; 

begin

Rd <= Instruction(15 downto 12);
Rm <= Instruction(3 downto 0);
Rn <= Instruction(19 downto 16);
Imm <= Instruction(7 downto 0);
Offset <= Instruction(23 downto 0);
N <= PSR(31);

process(Instruction)
begin
	if Instruction(27 downto 25) = "000" then
		if Instruction(24 downto 21) = "0100" then
			instr_courante <= ADDr;
		end if;
	elsif Instruction(27 downto 25) = "001" then
		if Instruction(24 downto 21) = "0100" then
			instr_courante <= ADDi;
		elsif Instruction(24 downto 21) = "1101" then
			instr_courante <= MOV;
		elsif Instruction(24 downto 21) = "1010" then
			instr_courante <= CMP;
		end if;
	elsif Instruction(27 downto 20) = "01100001" then
			instr_courante <= LDR;
	elsif Instruction(27 downto 20) = "01100000" then
			instr_courante <= STR;
	elsif Instruction(31 downto 24) = "11101010" then
			instr_courante <= BAL;
	elsif Instruction(31 downto 24) = "10111010" then
			instr_courante <= BLT;
	end if;
end process;

process(Instruction, instr_courante, N)
begin

RegSel <= '0';
nPCSel <= '0';
RegWr  <= '0';
MeMWr  <= '0';
ALUSrc <= '0';
ALUctr <= "00";
PSREn  <= '0';
WrSrc  <= '0';

case instr_courante is
when MOV =>
	RegWr <= '1';
	ALUSrc <= '1';
	ALUCtr <= "01";
when ADDi =>
	RegWr <= '1';
	ALUSrc <= '1';
when ADDr =>
	RegWr <= '1';
when CMP =>
	ALUSrc <= '1';
	PSREn <= '1';
	ALUCtr <= "10";
when LDR =>
	RegWr <= '1';
	ALUSrc <= '1';
	WrSrc <= '1';
when STR =>
	ALUSrc <= '1';
	MeMWr <= '1';
	RegSel <= '1';
when BAL =>
	nPCSel <= '1';
when BLT =>
	nPCSel <= N;

end case;
end process;

end architecture;