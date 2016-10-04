library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity InstructionMemory is
port(Address : in std_logic_vector(31 downto 0);
		ReadData : out std_logic_vector(31 downto 0));
end InstructionMemory;

architecture behav of InstructionMemory is
--Change the size of the array depending on how many bytes are required
-- to execute the desired instructions
type instruct_array is array (2**8-1 downto 0) of std_logic_vector(7 downto 0);
signal instruct_temp : instruct_array := 
  (    0 => "10001101", --lw $s5,0($t0)
       1 => "00010101",
       2 => "00000000",
       3 => "00000000",
       4 => "10001101", --lw $s6,4($t0)
       5 => "00010110",
       6 => "00000000",
       7 => "00000100",
       8 => "00000010", --slt $t7,$s5,$s6
       9 => "10110110",
      10 => "01111000",
      11 => "00101010",
      12 => "00010001", --beq $s7,$zero,L
      13 => "11100000",
      14 => "00000000",
      15 => "00000010",
      16 => "00000010", --sub $s1,$s2,$3
      17 => "01000011",
      18 => "10001000",
      19 => "00100010",
      20 => "00001000", --j exit
      21 => "00000000",
      22 => "00000000",
      23 => "00000111",
      24 => "00000010", --sub $s1,$s2,$s3
      25 => "01010011",
      26 => "10001000",
      27 => "00100010",
      28 => "10101101", --sw $s3,8($t0)
      29 => "00010011",
      30 => "00000000",
      31 => "00001100",
  others => "00000000");
  
begin

process(Address)
  variable i : integer;
begin
    i := conv_integer(unsigned(Address));
		ReadData <= instruct_temp(i) & instruct_temp(i+1) & instruct_temp(i+2) &
		                instruct_temp(i+3);
end process;
end behav;

