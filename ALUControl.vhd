library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ALUControl is
	port(
		ALUOp : in std_logic_vector(1 downto 0);
		Funct : in std_logic_vector(5 downto 0);
		Operation : out std_logic_vector(3 downto 0)
	);
end ALUControl;

architecture Structural of ALUControl is
begin

process(ALUOp, Funct)
  variable functTemp : std_logic_vector(3 downto 0);
begin
  functTemp := Funct(3 downto 0);
case ALUOp is
	when "00" =>
		Operation <= "0010";
	when "01" =>
		Operation <= "0110";
	when "10" =>
		case functTemp is
			when "0000" =>
				Operation <= "0010";
			when "0010" =>
				Operation <= "0110";
			when "0100" =>
				Operation <= "0000";
			when "0101" =>
				Operation <= "0001";
			when "1010" =>
				Operation <= "0111";
			when others =>
				null;
		end case;
	when "11" =>
		case functTemp is
			when "0010" =>
				Operation <= "0110";
			when "1010" =>
				Operation <= "0111";
			when others =>
				null;
		end case;
	when others =>
		null;
end case;
end process;

end Structural;
