library ieee;
use ieee.std_logic_1164.ALL;

entity IR is
	port (
		x: in std_logic_vector(31 downto 0);
    clk, IRWrite: in std_logic;
    y: out std_logic_vector(31 downto 0)
	);
end IR;

architecture Structural of IR is
begin
  process(clk)
    variable temp: std_logic_vector(31 downto 0) := X"00000000";
  begin
    y <= temp;
    if rising_edge(clk) then
      if IRWRite = '1' then
        temp := x;
      end if;
    end if;
  end process;
end Structural;
