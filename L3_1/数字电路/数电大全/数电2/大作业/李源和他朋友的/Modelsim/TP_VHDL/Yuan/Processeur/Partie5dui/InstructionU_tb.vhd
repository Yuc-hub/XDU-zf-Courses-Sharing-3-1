LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity InstructionU_tb is
end entity;

architecture BENCH of InstructionU_tb is

	signal Instruction :  std_logic_vector(31 downto 0);
	signal Clk  :  std_logic := '0';
	signal rst, nPCsel :  std_logic;
	signal Offset : std_logic_vector(23 downto 0);
	signal Done : boolean := False;
	constant Period : time := 20 ns;

begin

	UUT : entity work.InstructionU port map(
	clk=>clk, rst=> rst, nPCsel =>nPCsel, Offset => Offset,
	Instruction => Instruction);

	CLK <= '0' when Done else not CLK after Period / 2;
	Rst <= '1', '0' after 5 ns;

process
begin
-- PC <= PC + 1 = 1 ok???
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;

-- PC <= PC + 1 = 2 ok
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;


-- PC <= PC + 1 + Offset de +3 = 6 ok
nPCsel<= '1'; 
Offset <= x"000003"; 
wait for 20 ns;

-- PC <= PC + 1 = 7 ok
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;

-- PC <= PC + 1 + Offset de -4 = 4 ok
nPCsel<= '1'; 
Offset <= x"FFFFFC"; 
wait for 20 ns;

-- PC <= PC + 1 = 5 ok
nPCsel<= '0'; 
Offset <= (others => '0'); 
wait for 20 ns;

Done <= True; 
wait;

end process;

end architecture;