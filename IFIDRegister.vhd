library ieee;
use ieee.std_logic_1164.all;

entity IFIDRegister is
  port(
    clk: in std_logic;
    addressIn, instructionIn: std_logic_vector(31 downto 0);
    addressOut, instructionOut: out std_logic_vector(31 downto 0)
  );
end IFIDRegister;

architecture Structural of IFIDRegister is
  signal address, instruction: std_logic_vector(31 downto 0) := X"00000000";
begin
  addressOut <= address;
  instructionOut <= instruction;
process(clk)
  begin
    if rising_edge(clk) then
      address <= addressIn;
      instruction <= instructionIn;
    end if;
  end process;
end Structural;
