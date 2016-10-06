library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
	port (
		Address : in std_logic_vector(31 downto 0);
		ReadData : out std_logic_vector(31 downto 0)
	);
end InstructionMemory;

architecture Structural of InstructionMemory is
	type mem_array is array(0 to 31) of std_logic_vector(31 downto 0);
	signal inst_mem: mem_array := (
		0 => X"8d150000", -- lw $s5, 0($t0)
		1 => X"8d160004", -- lw $s6, 4($t0)
		2 => X"02b6782a", -- slt $t7, $s5, $s6
		3 => X"11f5fffc", -- beq $t7, $s5, $s6
		4 => X"11e00002", -- beq $t7, $zero, L
		5 => X"02538822", -- sub $s1, $s2, $s3
		6 => X"08000008", -- j exit
		7 => X"02538820", -- L: add $s1, $s2, $s3
		8 => X"ad11000c", -- exit: sw $s1, 12($t0)
		others => X"00000000"
	);
begin
	ReadData <= inst_mem(to_integer(unsigned(Address(6 downto 2))));
end Structural;
