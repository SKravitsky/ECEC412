library ieee;
use ieee.std_logic_1164.all;

entity EXMEMRegister is
  port(
    clk, aluSrcIn, branchIn, memWriteIn, memReadIn, memToRegIn, regDstIn, regWriteIn: in std_logic;
    aluOpIn: std_logic_vector(1 downto 0);
    writeRegisterIn: std_logic_vector(4 downto 0);
    addressIn, instructionIn, readDataOneIn, readDataTwoIn: std_logic_vector(31 downto 0);
    branchOut, memWriteOut, memReadOut, memToRegOut, regDstOut, regWriteOut: out std_logic;
    aluOpOut: std_logic_vector(1 downto 0);
    writeRegisterOut: std_logic_vector(4 downto 0);
    addressOut, instructionOut, readDataDataOneOut, readDataTwoOut: out std_logic_vector(31 downto 0)
  );
end EXMEMRegister;

architecture Structural of EXMEMRegister is
  signal branch, memWrite, memRead, memToReg, regWrite: std_logic := '0';
  signal aluOp: std_logic_vector(1 downto 0) := "00";
  signal writeRegister: std_logic_vector(4 downto 0) := "00000";
  signal address, instruction, readDataOne, readDataTwo: std_logic_vector(31 downto 0) := X"00000000";
begin
  addressOut <= address;
  branchOut <= branch;
  instructionOut <= instruction;
  memWriteOut <= memWrite;
  memReadOut <= memRead;
  memToRegOut <= memToReg;
  readDataOneOut <= readDataOne;
  readDataTwoOut <= readDataTwo;
  regWriteOut <= regWrite;
  writeRegisterOut <= writeRegister;
  writeDataOut <= readData;
  aluResultOut <= aluResult;
process(clk)
  begin
    if rising_edge(clk) then
      address <= addressIn;
      branch <= branchIn;
      instruction <= instructionIn;
      memWrite <= memWriteIn;
      memRead <= memReadIn;
      memToReg <= memToRegIn;
      readDataOne <= readDataOneIn;
      readDataTwo <= readDataTwoIn;
      regWrite <= regWriteIn;
      writeRegister <= writeRegisterIn;
      writeData <= writeDataIn;
      aluResult <= aluResultIn;
    end if;
  end process;
end Structural;
