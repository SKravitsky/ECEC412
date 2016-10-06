library ieee;
use ieee.std_logic_1164.all;

entity NOR32 is
	port(
		x: in std_logic_vector(31 downto 0);
		y: out std_logic
	);
end NOR32;

architecture Structural of NOR32 is
begin
	y <= '1' when x = x"00000000" else '0';
end Structural;
