library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignExtend is
port(x:in std_logic_vector(15 downto 0);
     y:out std_logic_vector(31 downto 0));
end SignExtend;

architecture Behavioral of SignExtend is

begin
process(x)
begin
	if  x(15) = '0' then
		y <= "0000000000000000" & x;
	elsif x(15) = '1' then
		y <= "1111111111111111" & x;
	end if;
end process;

end Behavioral;

