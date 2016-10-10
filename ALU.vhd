library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  generic(
    n: natural := 32
  );
  port(
    a, b: in std_logic_vector(n-1 downto 0);
    Oper: in std_logic_vector(3 downto 0);
    Result: buffer std_logic_vector(n-1 downto 0);
    Zero, CarryOut, Overflow: buffer std_logic
  );
end ALU;

architecture Structural of ALU is
  signal carry: std_logic := '0';
  signal ovf: std_logic := '0';
  signal temp: std_logic_vector(n-1 downto 0) := (
    others => '0'
  );
begin
  Zero <= '1' when temp = x"00000000" else '0';
  Result <= temp;
  CarryOut <= carry;
  Overflow <= ovf;
  process(a, b, Oper)
  begin
    carry <= '0';
    ovf <= '0';
    case Oper(2 downto 0) is
      when "000" =>
        temp <= a and b;
      when "001" =>
        temp <= a or b;
      when "111" =>
        if signed(a) < signed(b) then
          temp <= (0 => '1', others => '0');
        else
          temp <= (others => '0');
        end if;
      when others =>
        if oper(2) = '0' then
          temp <= std_logic_vector(signed(a) + signed(b));
        else
          temp <= std_logic_vector(signed(a) - signed(b));
        end if;
        if (a(n-1) = b(n-1)) and (not a(n-1) = temp(n-1)) then
          ovf <= '1';
        end if;
    end case;
  end process;
end Structural;
