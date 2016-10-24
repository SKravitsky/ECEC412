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
  type mem_array is array(0 to 32) of std_logic_vector(31 downto 0);
	-- Most likely need to initialize
  signal data_mem: mem_array := (
  0 => X"00000000",
  others => x"00000000"
  );
  signal temp_data: std_logic_vector(31 downto 0) := X"00000000";
begin
  ReadData <= temp_data;
  process(MemRead, MemWrite)
  begin
    if MemWrite = '1' then
      data_mem(to_integer(unsigned(Address)) / 4) <= WriteData;
    end if;
    if MemRead = '1' then
      temp_data <= data_mem(to_integer(unsigned(Address)) / 4);
    end if;
  end process;
end Structural;
