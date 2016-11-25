library ieee;
use ieee.std_logic_1164.all;

entity MEMWBRegister is
  port(
    regwr_in, memtoreg_in: in std_logic;
    clk: in std_logic;
    regwr_out, memtoreg_out: out std_logic
  );
end MEMWBRegister;

architecture Structural of MEMWBRegister is
signal regwr, memtoreg: std_logic;
begin
  process(clk)
  begin
    if rising_edge(clk) then
    	regwr_out <= regwr;
    	memtoreg_out <= memtoreg;
    else
      regwr <= regwr_in;
      memtoreg <= memtoreg_in;
    end if;
  end process;
end Structural;