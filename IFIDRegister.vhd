library ieee;
use ieee.std_logic_1164.all;

entity IFIDRegister is
  port(
    clk: in std_logic;
    AddressIn, InstructionIn: in std_logic_vector(31 downto 0);
    AddressOut, InstructionOut: out std_logic_vector(31 downto 0)
  );
end IFIDRegister;

architecture Structural of IFIDRegister is
  signal Address, Instruction: std_logic_vector(31 downto 0) := X"00000000";
begin
  AddressOut <= Address;
  InstructionOut <= Instruction;
process(clk)
  begin
    if rising_edge(clk) then
      Address <= AddressIn;
      Instruction <= InstructionIn;
    end if;
  end process;
end Structural;
