library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemoryPipeline is
  port(
    WriteData: in std_logic_vector(31 downto 0);
    Address: in std_logic_vector(31 downto 0);
    MemRead, MemWrite: in std_logic;
    ReadData: out std_logic_vector(31 downto 0)
  );
end DataMemoryPipeline;

Architecture Structural of DataMemoryPipeline is
  type mem_array is array(0 to 55) of std_logic_vector(31 downto 0);
  signal data_mem: mem_array := (
    -- Data Memory
    0 => X"00000004",
    1 => X"00000004",
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
