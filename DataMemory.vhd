library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory is
  port(
    WriteData: in std_logic_vector(31 downto 0);
    Address: in std_logic_vector(31 downto 0);
    Clk, MemRead, MemWrite: in std_logic;
    ReadData: out std_logic_vector(31 downto 0)
  );
end DataMemory;

architecture Structural of DataMemory is
  type mem_array is array(0 to 32) of std_logic_vector(31 downto 0);
  signal data_mem: mem_array := (
    1 => X"00000004",
    2 => X"00000005",
    others => X"00000000"
  );
  signal tempData: std_logic_vector(31 downto 0) := X"00000000";
begin
  ReadData <= tempData;
  process(Clk)
  begin
    if falling_edge(Clk) then
      if MemWrite = '1' then
        data_mem(to_integer(unsigned(Address)) / 4) <= WriteData;
      end if;
      if MemRead = '1' then
        tempData <= data_mem(to_integer(unsigned(Address)) / 4);
      end if;
    end if;
  end process;
end Structural;
