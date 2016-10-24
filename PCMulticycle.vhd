library ieee;
use ieee.std_logic_1164.all;

entity PCMulticycle is
  port(
    clk, d: in std_logic;
    AddressIn: in std_logic_vector(31 downto 0);
    AddressOut: out std_logic_vector(31 downto 0)
  );
end PCMulticycle;

architecture Structural of PCMulticycle is
  signal temp: std_logic_vector(31 downto 0) := X"00000000";
begin
  AddressOut <= temp;
  process(clk)
  begin
    AddressOut <= temp;
    if rising_edge(clk) and d='1' then
      temp <= AddressIn;
    end if;
  end process;
end Structural;
