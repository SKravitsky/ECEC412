library ieee;
use ieee.std_logic_1164.all;

entity MEMWBRegister is
  port(
    memreaddata_in, wrregaddress_in, aluresult_in: std_logic_vector(31 downto 0);
    regwr_in, memtoreg_in,clk: in std_logic;
    memreaddata_out, wrregaddress_out, aluresult_out: out std_logic_vector(31 downto 0);
    regwr_out, memtoreg_out: out std_logic
  );
end MEMWBRegister;

architecture Structural of MEMWBRegister is
signal memreaddata, wrregaddress, aluresult: std_logic_vector(31 downto 0);
signal regwr, memtoreg: std_logic;
begin
  process(clk)
  begin
    if rising_edge(clk) then
      memreaddata_out <= memreaddata;
      wrregaddress_out <= wrregaddress;
      aluresult_out <= aluresult;
      regwr_out <= regwr;
      memtoreg_out <= memtoreg;
    else
      memreaddata <= memreaddata_in;
      wrregaddress <= wrregaddress_in;
      aluresult <= aluresult_in;
      regwr <= regwr_in;
      memtoreg <= memtoreg_in;
    end if;
  end process;
end Structural;