library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity And2 is
port( a, b: in std_logic; 
		y: out std_logic );
end And2;

architecture Behavioral of And2 is

begin

y <= a and b;

end Behavioral;

