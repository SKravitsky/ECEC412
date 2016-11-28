library ieee;
use ieee.std_logic_1164.all;

entity MEMWBRegister is
  port(
    clk, MemtoRegIn, RegWriteIn: in std_logic;
    WriteRegisterIn: in std_logic_vector(4 downto 0);
    ReadDataIn, ALUResultIn: in std_logic_vector(31 downto 0);
    MemtoRegOut, RegWriteOut: out std_logic;
    WriteRegisterOut: out std_logic_vector(4 downto 0);
    ReadDataOut, ALUResultOut: out std_logic_vector(31 downto 0)
  );
end MEMWBRegister;

architecture Structural of MEMWBRegister is
  signal MemtoReg, RegWrite: std_logic := '0';
  signal WriteRegister: std_logic_vector(4 downto 0) := "00000";
  signal ReadData, ALUResult: std_logic_vector(31 downto 0) := X"00000000";
begin
  MemtoRegOut <= MemtoReg;
  RegWriteOut <= RegWrite;
  WriteRegisterOut <= WriteRegister;
  ReadDataOut <= ReadData;
  ALUResultOut <= ALUResult;
  process(clk)
  begin
    if rising_edge(clk) then
      MemtoReg <= MemtoRegIn;
      RegWrite <= RegWriteIn;
      WriteRegister <= WriteRegisterIn;
      ReadData <= ReadDataIn;
      ALUResult <= ALUResultIn;
    end if;
  end process;
end Structural;
