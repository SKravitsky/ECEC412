library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
  port(
    clk: in std_logic;
    AddressIn: in std_logic_vector(31 downto 0);
    AddressOut: out std_logic_vector(31 downto 0)
  );
end PC;

architecture Behavioral of PC is
begin
  process(clk)
    variable temp: std_logic_vector(31 downto 0) := X"00000000";
  begin
    AddressOut <= temp;
    if falling_edge(clk) then
      temp := AddressIn;
    else
    end if;
  end process;
end Behavioral;
