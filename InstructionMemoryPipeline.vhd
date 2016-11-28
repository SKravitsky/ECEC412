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
    -- Code 1
		0 => X"02959820", -- add $s3, $s4, $s5
		1 => X"8d100000", -- lw $s0, 0($t0)
		2 => X"8d110004", -- lw $s1, 4($t0)
		3 => X"0296b822", -- sub $s7, $s4, $s6
		4 => X"ad130008", -- sw $s3, 8($t0)
    -- Code 2
    -- 0 => X"02959820", -- add $s3, $s4, $s5
    -- 1 => X"8d100000", -- lw $s0, 0($t0)
    -- 2 => X"8d110004", -- lw $s1, 4($t0)
    -- 3 => X"0296b822", -- sub $s7, $s4, $s6
    -- 4 => X"ad170008", -- sw $s7, 8($t0)
    -- Code 3
    -- 0 => X"02959820", -- add $s3, $s4, $s5
    -- 1 => X"8d100000", -- lw $s0, 0($t0)
    -- 2 => X"8d110004", -- lw $s1, 4($t0)
    -- 3 => X"0296b822", -- sub $s7, $s4, $s6
    -- 4 => X"00000020", -- nop
    -- 5 => X"00000020", -- nop
    -- 6 => X"ad170008", -- sw $s7, 8($t0)
    -- Code 4
    -- 0 => X"112a0005", -- beq $t1, $t2, L
    -- 1 => X"00000020", -- nop
    -- 2 => X"00000020", -- nop
    -- 3 => X"00000020", -- nop
    -- 4 => X"02955820", -- add $t3, $s4, $s5
    -- 5 => X"08000008", -- j exit
    -- 6 => X"02956022", -- L: sub $t4, $s4, $s5
    -- 7 => X"02946820", -- add $t5, $s4, $s4
    -- Code 5
    -- 0 => X"112a0005", -- beq $t1, $t2, L
    -- 1 => X"00000020", -- nop
    -- 2 => X"02955820", -- add $t3, $s4, $s5
    -- 3 => X"08000008", -- j exit
    -- 4 => X"02956022", -- L: sub $t4, $s4, $s5
    -- 5 => X"02946820", -- add $t5, $s4, $s4
		others => X"00000000"
	);
begin
	ReadData <= inst_mem(to_integer(unsigned(Address)) / 4);
end Structural;
