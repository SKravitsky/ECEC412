library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- SHIFT LEFT 2
entity SHIFTLEFT2 is
  port( X:in STD_LOGIC_VECTOR(31 downto 0);
        Y:out STD_LOGIC_VECTOR(31 downto 0));
end SHIFTLEFT2;

-- PROCESS
architecture SL2_BEH of SHIFTLEFT2 is
begin
  process (X)
    variable SHIFTED_SIG:STD_LOGIC_VECTOR(31 downto 0);
    begin
      --LOOP AND SHIFT 32 times.
      for k in 31 downto 2 loop
        SHIFTED_SIG(k):=X(k-2);
      end loop;
      SHIFTED_SIG(1):='0';
      SHIFTED_SIG(0):='0';
    
      Y<=SHIFTED_SIG;
    end process;
end SL2_BEH;
    