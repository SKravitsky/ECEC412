library ieee;
use ieee.std_logic_1164.all;

entity IDEXRegister is
  port(
    clk, BranchIn, MemWriteIn, MemReadIn, MemtoRegIn, RegDstIn, RegWriteIn: in std_logic;
    ALUOpIn: std_logic_vector(1 downto 0);
    AddressIn, InstructionIn, ReadDataOneIn, ReadDataTwoIn: std_logic_vector(31 downto 0);
    BranchOut, MemWriteOut, MemReadOut, MemtoRegOut, RegDstOut, RegWriteOut: out std_logic;
    ALUOpOut: out std_logic_vector(1 downto 0);
    AddressOut, InstructionOut, ReadDataOneOut, ReadDataTwoOut: out std_logic_vector(31 downto 0)
  );
end IDEXRegister;

architecture Structural of IDEXRegister is
  signal Branch, MemWrite, MemRead, MemtoReg, RegDst, RegWrite: std_logic := '0';
  signal ALUOp: std_logic_vector(1 downto 0) := "00";
  signal Address, Instruction, ReadDataOne, ReadDataTwo: std_logic_vector(31 downto 0) := X"00000000";
begin
  AddressOut <= Address;
  ALUOPOut <= ALUOp;
  BranchOut <= Branch;
  InstructionOut <= Instruction;
  MemWriteOut <= MemWrite;
  MemReadOut <= MemRead;
  MemtoRegOut <= MemtoReg;
  ReadDataOneOut <= ReadDataOne;
  ReadDataTwoOut <= ReadDataTwo;
  RegDstOut <= RegDst;
  RegWriteOut <= RegWrite;
process(clk)
  begin
    if rising_edge(clk) then
      Address <= AddressIn;
      ALUOp <= ALUOpIn;
      Branch <= BranchIn;
      Instruction <= InstructionIn;
      MemWrite <= MemWriteIn;
      MemRead <= MemReadIn;
      MemtoReg <= MemtoRegIn;
      ReadDataOne <= ReadDataOneIn;
      ReadDataTwo <= ReadDataTwoIn;
      RegDst <= RegDstIn;
      RegWrite <= RegWriteIn;
    end if;
  end process;
end Structural;
