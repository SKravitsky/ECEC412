library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

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
    0 => X"00000000",
    others => X"00000000"
  );
  signal tempData: std_logic_vector(31 downto 0) := X"00000000";
begin
  ReadData <= tempData;
  process(Clk)
  begin
    if rising_edge(Clk) then
      if MemWrite = '1' then
        data_mem(to_integer(unsigned(Address))) <= WriteData;
      end if;
      if MemRead = '1' then
        tempData <= data_mem(to_integer(unsigned(Address)));
      end if;
    end if;
  end process;
end Structural;
