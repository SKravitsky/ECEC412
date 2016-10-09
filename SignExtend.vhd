library ieee;
use ieee.std_logic_1164.all;

entity SignExtend is
  port(
    x: in std_logic_vector(15 downto 0);
    y: out std_logic_vector(31 downto 0)
  );
end SignExtend;

architecture Structural of SignExtend is
begin
  process(x)
  begin
    if x(15) = '0' then
      y <= "0000000000000000" & x;
    elsif x(15) = '1' then
      y <= "1111111111111111" & x;
    end if;
  end process;
end Structural;
