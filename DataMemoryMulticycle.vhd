library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemoryMulticycle is
  port(
    WriteData: in std_logic_vector(31 downto 0);
    Address: in std_logic_vector(31 downto 0);
    MemRead, MemWrite: in std_logic;
    ReadData: out std_logic_vector(31 downto 0)
  );
end DataMemoryMulticycle;

Architecture Structural of DataMemoryMulticycle is
  type mem_array is array(0 to 55) of std_logic_vector(31 downto 0);
  signal data_mem: mem_array := (
    -- Instruction Memory
    0 => X"8d100028", --       lw $s0, 40($t0)
    1 => X"8d11002c", --       lw $s1, 44($t0)
    2 => X"12110002", --       beq $s0, $s1, L
    3 => X"02959820", --       add $s3, $s4, $s5
    4 => X"08000006", --       j exit
    5 => X"02959822", -- L:    sub $s3, $s4, $s5
    6 => X"ad130030", -- exit: sw $s3, 48($t0)
    -- Data Memory
    10 => X"00000004",
    11 => X"00000004", -- Branch Taken
    -- 11 => X"FFFFFFFB", -- Branch Untaken
    others => x"00000000"
  );
  signal temp_data: std_logic_vector(31 downto 0) := X"00000000";
begin
  ReadData <= temp_data;
  process(WriteData, Address, MemRead, MemWrite)
  begin
    if MemWrite = '1' then
      data_mem(to_integer(unsigned(Address)) / 4) <= WriteData;
    end if;
    if MemRead = '1' then
      temp_data <= data_mem(to_integer(unsigned(Address)) / 4);
    end if;
  end process;
end Structural;
