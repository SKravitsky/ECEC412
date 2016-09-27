library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc is
port( clk: in std_logic;
		AddressIn: in std_logic_vector(31 downto 0);
		AddressOut: out std_logic_vector(31 downto 0));
end pc;

architecture Behavioral of pc is

begin
process(clk, AddressIn)
begin
if clk='1' and clk'event then
	if AddressIn = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
		AddressOut <= "00000000000000000000000000000000";
	else
		AddressOut <= AddressIn; 
	end if;      
end if;  
end process;

end Behavioral;

