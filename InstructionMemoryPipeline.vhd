library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemoryPipeline is
	port (
		Address : in std_logic_vector(31 downto 0);
		ReadData : out std_logic_vector(31 downto 0)
	);
end InstructionMemoryPipeline;

architecture Structural of InstructionMemoryPipeline is
	type mem_array is array(0 to 31) of std_logic_vector(31 downto 0);
	signal inst_mem: mem_array := (
		0 => X"02959820", -- add $s3, $s4, $s5
		1 => X"8d100000", -- lw $s0, 0($t0)
		2 => X"8d110004", -- lw $s1, 4($t0)
		3 => X"0296b822", -- sub $s7, $s4, $s6
		4 => X"ad130008", -- sw $s3, 8($t0)
		others => X"00000000"
	);
begin
	ReadData <= inst_mem(to_integer(unsigned(Address)) / 4);
end Structural;
