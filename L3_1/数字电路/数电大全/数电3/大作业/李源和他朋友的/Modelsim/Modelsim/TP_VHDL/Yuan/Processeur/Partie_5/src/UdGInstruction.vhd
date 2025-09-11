LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity UdGInstruction is 
port (
			clk, rst, nPCsel : in  std_logic ; 
			Instruction : out std_logic_vector(31 downto 0);
			Offset : in std_logic_vector(23 downto 0)
		);
end entity;

architecture BEHAVIOUR of UdGInstruction is
signal PC, Offset_s : std_logic_vector(31 downto 0);  
begin

U1 : entity work.instruction_memory2 port map (
PC=> PC, Instruction=> Instruction); 

U2 : entity work.Extension generic map(N=> 24) 
port map ( E => Offset, S => Offset_s); 



process(clk, rst) 
begin 
if rst ='1' then 
	PC <= (others => '0'); 
elsif rising_edge(clk) then 
	if nPCsel = '0' then 
		PC <= std_logic_vector(unsigned(PC)+1);	
	else 
		PC <= std_logic_vector(unsigned(PC)+1+ unsigned(offset_s));	
	end if; 
end if; 
end process; 


end architecture;
