library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegB is
  port(
    x: in std_logic_vector(31 downto 0);
    clk: in std_logic;
    y: out std_logic_vector(31 downto 0)
  );
end RegB;

architecture Structural of RegB is
  signal temp: std_logic_vector(31 downto 0) := X"00000000";
begin
  y <= temp;
  process(clk)
    begin
      if rising_edge(clk) then
        temp <= x;
      end if;
  end process;
end Structural;
