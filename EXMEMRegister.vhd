library ieee;
use ieee.std_logic_1164.all;

entity EXMEMRegister is
  port(
    clk, BranchIn, MemWriteIn, MemReadIn, MemtoRegIn, RegWriteIn, ZeroIn: in std_logic;
    writeRegisterIn: std_logic_vector(4 downto 0);
    AddressIn, ALUResultIn, WriteDataIn: std_logic_vector(31 downto 0);
    BranchOut, MemWriteOut, MemReadOut, MemtoRegOut, RegWriteOut, ZeroOut: out std_logic;
    writeRegisterOut: std_logic_vector(4 downto 0);
    AddressOut, ALUResultOut, WriteDataOut: out std_logic_vector(31 downto 0)
  );
end EXMEMRegister;

architecture Structural of EXMEMRegister is
  signal Branch, MemWrite, MemRead, MemtoReg, RegWrite, Zero: std_logic := '0';
  signal writeRegister: std_logic_vector(4 downto 0) := "00000";
  signal Address, ALUResult, WriteData: std_logic_vector(31 downto 0) := X"00000000";
begin
  AddressOut <= Address;
  BranchOut <= Branch;
  MemWriteOut <= MemWrite;
  MemReadOut <= MemRead;
  MemtoRegOut <= MemtoReg;
  RegWriteOut <= RegWrite;
  ZeroOut <= Zero;
  writeRegisterOut <= writeRegister;
  WriteDataOut <= readData;
  ALUResultOut <= ALUResult;
process(clk)
  begin
    if rising_edge(clk) then
      Address <= AddressIn;
      Branch <= BranchIn;
      MemWrite <= MemWriteIn;
      MemRead <= MemReadIn;
      MemtoReg <= MemtoRegIn;
      RegWrite <= RegWriteIn;
      Zero <= ZeroIn;
      writeRegister <= writeRegisterIn;
      WriteData <= WriteDataIn;
      ALUResult <= ALUResultIn;
    end if;
  end process;
end Structural;
