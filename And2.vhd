library ieee;
use ieee.std_logic_1164.all;
entity And2 is
  port(
    a, b: in std_logic;
    y: out std_logic
  );
end And2;

architecture Structural of And2 is
begin
  y <= a and b;
end Structural;
