library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory3 is
port(
	PC: in std_logic_vector (31 downto 0);
	Instruction: out std_logic_vector (31 downto 0)
	);
end entity;

architecture RTL of instruction_memory3 is
	type RAM64x32 is array (0 to 63) of std_logic_vector (31 downto 0);
	
	function init_mem return RAM64x32 is
		variable result : RAM64x32;
	begin
		for i in 63 downto 0 loop
			result (i):=(others=>'0');
		end loop; -- PC -- INSTRUCTION -- COMMENTAIRE
		result (0 ):=x"E3A00020";-- 0x0  -- MOV R0,#0x20 	-- R0 = 0x20
		result (1 ):=x"E3A02001";-- 0x1  -- MOV R2,#0x01 	-- R2 = 1		
		result (2 ):=x"E3A02000";-- 0x2  -- MOV R2,#0x00 	-- R2 = 0
		result (3 ):=x"E3A01000";-- 0x3  -- MOV R1,#0x00 	-- R1 = 0
		result (4 ):=x"E6103000";-- 0x4  -- LDR R3,0(R0) 	-- R3 = DATAMEM[R0]
		result (5 ):=x"E6104001";-- 0x5  -- LDR R4,0(R0,#1) -- R4 = DATAMEM[R0,#1]
		result (6 ):=x"E1530004";-- 0x6  -- CMP R3,R4       -- si R3 >=R4		
		result (7 ):=x"BA000002";-- 0x7  -- BLT loop 		-- PC = PC + (2) si N = 1
		result (8 ):=x"E6004000";-- 0x8  -- STR R4,0(R0) 	-- DATAMEM[R0] = R4
		result (9 ):=x"E6003001";-- 0x9  -- STR R3,0(R0,#1) -- DATAMEM[R0,#1] = R3		
		result (10):=x"E2800001";-- 0xA  -- ADD R0,R0,#1    -- R0 = R0 + 1
		result (11):=x"E2811001";-- 0xB  -- ADD R1,R1,#1    -- R1 = R1 + 1
		result (12):=x"E3510007";-- 0xC  -- CMP R1,0x07 	-- si R1 >= 0x07
		result (13):=x"BAFFFFF6";-- 0xD  -- BLT loop 		-- PC = PC + (-10) si N = 1
		result (14):=x"E2822001";-- 0xE  -- ADD R2,R2,#1    -- R2 = R2 + 1
		result (15):=x"E3520007";-- 0xF  -- CMP R2,0x07 	-- si R2 >= 0x07
		result (16):=x"E3A00020";-- 0x10 -- MOV R0,#0x20 	-- R0 = 0x20
		result (17):=x"FAFFFFF0";-- 0x11 -- BEN while		-- PC = PC + (-16) si Z = 1	
		
		return result;
	end init_mem;
	
	signal mem: RAM64x32 := init_mem;
begin

	Instruction <= mem(to_integer (unsigned (PC(5 downto 0))));
	
end architecture;