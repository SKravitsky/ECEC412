library ieee;
use ieee.std_logic_1164.all;

entity MUX3Way is
  port(
    w, x, y: in std_logic_vector(31 downto 0);
    sel: in std_logic_vector(1 downto 0);
    z:out std_logic_vector(31 downto 0)
  );
end MUX3Way;

Architecture Structural of MUX3Way is
begin
  process(sel)
  begin
    case sel is
      when "00" =>
	z <= w;
      when "01" =>
	z <= x;
      when "10" =>
        z <= y;
      when others =>
        z <= X"00000000";
    end case;
  end process;
end Structural;