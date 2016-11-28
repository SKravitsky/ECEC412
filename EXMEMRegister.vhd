library ieee;
use ieee.std_logic_1164.all;

entity EXMEMRegister is
  port(
    clk, branchIn, memWriteIn, memReadIn, memToRegIn, regWriteIn, zeroIn: in std_logic;
    writeRegisterIn: std_logic_vector(4 downto 0);
    writeDataIn aluResultIn: std_logic_vector(31 downto 0);
    branchOut, memWriteOut, memReadOut, memToRegOut, regWriteOut, zeroOut: out std_logic;
    writeRegisterOut: std_logic_vector(4 downto 0);
    writeDataOut, aluResultOut: out std_logic_vector(31 downto 0)
  );
end EXMEMRegister;

architecture Structural of EXMEMRegister is
  signal branch, memWrite, memRead, memToReg, regWrite, zero: std_logic := '0';
  signal writeRegister: std_logic_vector(4 downto 0) := "00000";
  signal writeData, aluResult: std_logic_vector(31 downto 0) := X"00000000";
begin
  branchOut <= branch;
  memWriteOut <= memWrite;
  memReadOut <= memRead;
  memToRegOut <= memToReg;
  regWriteOut <= regWrite;
  zeroOut <= zero;
  writeRegisterOut <= writeRegister;
  writeDataOut <= readData;
  aluResultOut <= aluResult;
  process(clk)
  begin
    if rising_edge(clk) then
      branch <= branchIn;
      memWrite <= memWriteIn;
      memRead <= memReadIn;
      memToReg <= memToRegIn;
      regWrite <= regWriteIn;
      zero <= zeroIn;
      writeRegister <= writeRegisterIn;
      writeData <= writeDataIn;
      aluResult <= aluResultIn;
    end if;
  end process;
end Structural;