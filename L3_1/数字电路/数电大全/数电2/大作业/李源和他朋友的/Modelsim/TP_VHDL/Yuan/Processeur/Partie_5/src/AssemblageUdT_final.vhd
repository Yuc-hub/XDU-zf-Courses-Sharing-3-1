LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity AssemblageUdT_final is 
port (
	clk, rst, MemWr, RegWr, ALUsrc, WrSrc, RegSel, PSREn: in  std_logic ; 
	Rn, Rd, Rm : in std_logic_vector(3 downto 0);
	PSR : out std_logic_vector(31 downto 0);
	Imm : in std_logic_vector(7 downto 0); 
	ALUctr : in std_logic_vector(1 downto 0)
		);
end entity;

architecture BEHAVIOUR of AssemblageUdT_final is
signal busA,busB,ALUout,busExt,busMux, busW : std_logic_vector(31 downto 0);
signal DataOut, flags : std_logic_vector(31 downto 0);
signal Ra, Rb, Rw : std_logic_vector(3 downto 0); 
signal N : std_logic; 
begin

U1 : entity work.BancRegistre port map(
Clk => clk, rst => rst, WE=> RegWr, Ra => Ra, Rb => Rb, Rw => Rw, 
A => busA, B => busB, W=> busW); 

U2 : entity work.ALU port map(
A => busA, B=> busMux, S => ALUout, OP => ALUctr, N => N); 

U3 : entity work.Extension port map ( E => Imm, S => busExt);

U4 : entity work.MUX2V1 port map (A => busB, B=> busEXT, S=> busMux, 
COM => ALUSrc); 

U5 : entity work.MUX2V1 port map (A => ALUout, B=> DataOut, S=> busW, 
COM => WrSrc);

U6 : entity work.DataMemory port map (Clk => clk, rst => rst, 
Addr => ALUOut(5 downto 0), WrEn => MemWr, DataIn => busB, 
DataOut => DataOut); 

U7 : entity work.MUX2V1 generic map( N=> 4) port map (
A => Rm, B => Rd, COM => RegSel, S=> Rb); 

U8 : entity work.Registre port map (
clk => clk, rst => rst, WE => PSREn, DataIn => flags, DataOut => PSR); 

Rw <= Rd; 
Ra <= Rn; 
flags <= N&"000"&x"0000000"; 
 


end architecture;
