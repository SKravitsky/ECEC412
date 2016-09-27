library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- SHIFT LEFT 2 JUMP
entity SHIFTLEFT2JUMP is
  port( X:in STD_LOGIC_VECTOR(25 downto 0);
        Y:in STD_LOGIC_VECTOR(3 downto 0);
        Z:out STD_LOGIC_VECTOR(31 downto 0));
end SHIFTLEFT2JUMP;

architecture SL2J_DF of SHIFTLEFT2JUMP is
--COMPONENTS USED
component SHIFTLEFT2 is
  port( X:in STD_LOGIC_VECTOR(31 downto 0);
        Y:out STD_LOGIC_VECTOR(31 downto 0));
end component;
--SIGNALS USED --
signal TMP32, TEMP32SL2:STD_LOGIC_VECTOR(31 downto 0);

begin
  TMP32 <= "000000" & X; -- I first concatenate 0 at the LEFT so that the shift component will accept the signal
  SL2: SHIFTLEFT2 port map (TMP32,TEMP32SL2); --Shift the signal with the shift component.
  Z<=Y & TEMP32SL2(27 downto 0); -- Concatenate the 4 bits to the 28 bit. and that is my output.
end SL2J_DF;