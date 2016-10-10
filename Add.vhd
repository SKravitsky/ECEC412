library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Add is
  port(
    x: in std_logic_vector(31 downto 0);
    y: in std_logic_vector(31 downto 0);
    z: out std_logic_vector(31 downto 0)
  );
end Add;

architecture Structural of Add is
begin
    z <= std_logic_vector(unsigned(x) + unsigned(y));
end Structural;
