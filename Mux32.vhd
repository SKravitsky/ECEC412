library ieee;
use ieee.std_logic_1164.all;

entity Mux32 is
  port(
    x, y: in std_logic_vector (31 downto 0);
    sel: in std_logic;
    z: out std_logic_vector(31 downto 0)
  );
end Mux32;

architecture Structural of Mux32 is
begin
  z <= y when sel = '1' else x;
end Structural;
