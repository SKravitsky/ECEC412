library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity NBIT_OR is
  generic (N:Natural:=32);
  port (A:in STD_LOGIC_VECTOR(N-1 downto 0);
        Z:out STD_LOGIC);
end NBIT_OR;

architecture NBIT_OR_GENER of NBIT_OR is
begin
  process (A)
    variable OR_OUT:STD_LOGIC;
  begin
    OR_OUT:='0';
    for k in 0 to N-1 loop
      OR_OUT:=OR_OUT or A(k);
      exit when OR_OUT='1';
    end loop;
    Z<=OR_OUT;
  end process;
end NBIT_OR_GENER;
    
    
