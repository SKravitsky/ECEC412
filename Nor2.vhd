library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Nor32 is
port( x: in std_logic_vector(31 downto 0);
		y: out std_logic);
end Nor32;

architecture Behavioral of Nor32 is

begin

process(x)
variable sig: std_logic;
begin
sig := '0';
for i in 31 downto 0 loop
	sig := sig nor x(i);
end loop;
y <= sig;
end process;

end Behavioral;

