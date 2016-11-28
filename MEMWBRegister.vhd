library ieee;
use ieee.std_logic_1164.all;

entity MEMWBRegister is
  port(
    clk, memToRegIn, regWriteIn: in std_logic;
    writeRegisterIn: std_logic_vector(4 downto 0);
    readDataIn aluResultIn: std_logic_vector(31 downto 0);
    memToRegOut, regWriteOut: out std_logic;
    writeRegisterOut: std_logic_vector(4 downto 0);
    readDataOut, aluResultOut: out std_logic_vector(31 downto 0)
  );
end MEMWBRegister;

architecture Structural of MEMWBRegister is
  signal memToReg, regWrite: std_logic := '0';
  signal writeRegister: std_logic_vector(4 downto 0) := "00000";
  signal readData, aluResult: std_logic_vector(31 downto 0) := X"00000000";
begin
  memToRegOut <= memToReg;
  regWriteOut <= regWrite;
  writeRegisterOut <= writeRegister;
  readDataOut <= readData;
  aluResultOut <= aluResult;
  process(clk)
  begin
    if rising_edge(clk) then
      memToReg <= memToRegIn;
      regWrite <= regWriteIn;
      writeRegister <= writeRegisterIn;
      readData <= readDataIn;
      aluResult <= aluResultIn;
    end if;
  end process;
end Structural;
