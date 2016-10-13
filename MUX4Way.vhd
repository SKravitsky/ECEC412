library ieee;
use ieee.std_logic_1164.all;

entity MUX4Way is
  port(
    v, w, x, y: in std_logic_vector(31 downto 0);
    sel: in std_logic_vector(1 downto 0);
    z:out std_logic_vector(31 downto 0)
  );
end MUX4Way;

architecture MUX4Way_Imp of MUX4Way is
	signal outsig: std_logic_vector(31 downto 0);
	
	begin
	
	process(sel)
	begin
	case sel is
		when "00" =>
			outsig <= v;
		when "01" =>
			outsig <= w;
		when "10" =>
			outsig <= x;
		when "11" =>
			outsig <= y;
		when others =>
			outsig <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	end case;
	z <= outsig;
	end process;
end MUX4Way_Imp;