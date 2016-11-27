library ieee;
use ieee.std_logic_1164.all;

entity MUX4Way is
  port(
    v, w, x, y: in std_logic_vector(31 downto 0);
    sel: in std_logic_vector(1 downto 0);
    z: out std_logic_vector(31 downto 0)
  );
end MUX4Way;

architecture Structural of MUX4Way is
begin
  process(v, w, x, y, sel)
  begin
    case sel is
      when "00" =>
        z <= v;
      when "01" =>
        z <= w;
      when "10" =>
        z <= x;
      when "11" =>
        z <= y;
      when others =>
        z <= X"00000000";
      end case;
  end process;
end Structural;
