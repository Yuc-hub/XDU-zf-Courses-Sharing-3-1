LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity AssemblageUdT is 
port (
			clk, rst, MemWr, RegWr, ALUsrc, WrSrc : in  std_logic ; 
			Ra, Rb, Rw : in std_logic_vector(3 downto 0);
			W : out std_logic_vector(31 downto 0);
			Imm : in std_logic_vector(7 downto 0); 
			N : out std_logic; 
			ALUctr : in std_logic_vector(1 downto 0)
		);
end entity;

architecture BEHAVIOUR of AssemblageUdT is
signal busA,busB,ALUout,busExt,busMux, busW : std_logic_vector(31 downto 0);
signal DataOut : std_logic_vector(31 downto 0);
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

  

W <= busw; 


end architecture;
