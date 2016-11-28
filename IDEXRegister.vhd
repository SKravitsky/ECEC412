library ieee;
use ieee.std_logic_1164.all;

entity EXMEMRegister is
  port(
    clk, aluSrcIn, BranchIn, MemWriteIn, MemReadIn, MemtoRegIn, regDstIn, RegWriteIn: in std_logic;
    ALUOpIn: std_logic_vector(1 downto 0);
    WriteRegisterIn: std_logic_vector(4 downto 0);
    AddressIn, InstructionIn, ReadDataOneIn, ReadDataTwoIn: std_logic_vector(31 downto 0);
    BranchOut, MemWriteOut, MemReadOut, MemtoRegOut, regDstOut, RegWriteOut: out std_logic;
    ALUOpOut: std_logic_vector(1 downto 0);
    WriteRegisterOut: std_logic_vector(4 downto 0);
    AddressOut, InstructionOut, readDataDataOneOut, ReadDataTwoOut: out std_logic_vector(31 downto 0)
  );
end EXMEMRegister;

architecture Structural of EXMEMRegister is
  signal Branch, MemWrite, MemRead, MemtoReg, RegWrite: std_logic := '0';
  signal ALUOp: std_logic_vector(1 downto 0) := "00";
  signal WriteRegister: std_logic_vector(4 downto 0) := "00000";
  signal Address, Instruction, ReadDataOne, ReadDataTwo: std_logic_vector(31 downto 0) := X"00000000";
begin
  AddressOut <= Address;
  BranchOut <= Branch;
  InstructionOut <= Instruction;
  MemWriteOut <= MemWrite;
  MemReadOut <= MemRead;
  MemtoRegOut <= MemtoReg;
  ReadDataOneOut <= ReadDataOne;
  ReadDataTwoOut <= ReadDataTwo;
  RegWriteOut <= RegWrite;
  WriteRegisterOut <= WriteRegister;
process(clk)
  begin
    if rising_edge(clk) then
      Address <= AddressIn;
      Branch <= BranchIn;
      Instruction <= InstructionIn;
      MemWrite <= MemWriteIn;
      MemRead <= MemReadIn;
      MemtoReg <= MemtoRegIn;
      ReadDataOne <= ReadDataOneIn;
      ReadDataTwo <= ReadDataTwoIn;
      RegWrite <= RegWriteIn;
      WriteRegister <= WriteRegisterIn;
    end if;
  end process;
end Structural;