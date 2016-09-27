library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU1 is
port( ALUctl : in std_logic_vector(3 downto 0);
		a,b : in std_logic;
		less,carryIn : in std_logic;
		result,carryOut : out std_logic);
end ALU1;

architecture behav of ALU1 is
begin

process(ALUctl,a,b,carryIn,less)
begin

case ALUctl is
	when "0000" =>
		result <= a and b;
	when "0001" =>
		result <= a or b;
	when "0010" =>
		result <= a xor b xor carryIn;
		carryOut <= (a and b) or (b and carryIn) or (a and carryIn);
	when "0110" =>
		result <= a xor (not b) xor carryIn;
		carryOut <= (a and (not b)) or ((not b) and carryIn) or (a and carryIn);
	when "0111" =>
		result <= less;
		carryOut <= (a and (not b)) or ((not b) and carryIn) or (a and carryIn);
	when "1100" =>
		result <= a nor b;
	when others =>
		result <= '0';
end case;
end process;

end behav;

