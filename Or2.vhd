library ieee;
use ieee.std_logic_1164.all;
entity Or2 is
  port(
    a, b: in std_logic;
    y: out std_logic
  );
end Or2;

architecture Structural of Or2 is
begin
  y <= a or b;
end Structural;
