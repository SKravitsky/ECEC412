library ieee;
use ieee.std_logic_1164.all;

entity PipelineCPU is
  port(
    clk: in std_logic;
    Overflow: out std_logic
  );
end PipelineCPU;

architecture Behavioral of CPU is
  component PC
  	port(
  		clk: in std_logic;
  		AddressIn: in std_logic_vector(31 downto 0);
  		AddressOut: out std_logic_vector(31 downto 0)
  	);
  end component;

  component Add
    port(
      x: in std_logic_vector(31 downto 0);
      y: in std_logic_vector(31 downto 0);
      z: out std_logic_vector(31 downto 0)
    );
  end component;

  component InstructionMemory
    port (
      Address: in std_logic_vector(31 downto 0);
      ReadData: out std_logic_vector(31 downto 0)
    );
  end component;

  component Mux32
    port(
      x, y: in std_logic_vector (31 downto 0);
      sel: in std_logic;
      z: out std_logic_vector(31 downto 0)
    );
  end component;

  component IFIDRegister is
    port(
      clk: in std_logic;
      addressIn, instructionIn: in std_logic_vector(31 downto 0);
      addressOut, instructionOut: out std_logic_vector(31 downto 0)
    );
  end component;

  component Registers
    port(
      RR1, RR2, WR: in std_logic_vector(4 downto 0);
      WD: in std_logic_vector(31 downto 0);
      RegWrite, Clk: in std_logic;
      RD1, RD2: out std_logic_vector(31 downto 0)
    );
  end component;

  component PipelineControl is
    port(
      Opcode: in std_logic_vector(5 downto 0);
      ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegDst, RegWrite: out std_logic;
      ALUOp: out std_logic_vector(1 downto 0)
    );
  end component;

  component IDEXRegister is
    port(
      clk, BranchIn, MemWriteIn, MemReadIn, MemtoRegIn, RegDstIn, RegWriteIn: in std_logic;
      ALUOpIn: std_logic_vector(1 downto 0);
      WriteRegisterIn: std_logic_vector(4 downto 0);
      AddressIn, InstructionIn, ReadDataOneIn, ReadDataTwoIn: std_logic_vector(31 downto 0);
      BranchOut, MemWriteOut, MemReadOut, MemtoRegOut, RegDstOut, RegWriteOut: out std_logic;
      ALUOpOut: std_logic_vector(1 downto 0);
      WriteRegisterOut: std_logic_vector(4 downto 0);
      AddressOut, InstructionOut, readDataDataOneOut, ReadDataTwoOut: out std_logic_vector(31 downto 0)
    );
  end component;


  component ALU is
    generic(
      n: natural := 32
    );
    port(
      a, b: in std_logic_vector(n-1 downto 0);
      Oper: in std_logic_vector(3 downto 0);
      Result: buffer std_logic_vector(n-1 downto 0);
      Zero, CarryOut, Overflow: buffer std_logic
    );
  end component;

  component ALUControl is
  	port(
  		ALUOp : in std_logic_vector(1 downto 0);
  		Funct : in std_logic_vector(5 downto 0);
  		Operation : out std_logic_vector(3 downto 0)
  	);
  end component;

  signal RegWrite: std_logic := '0';
  signal Operation: std_logic_vector(3 downto 0) := "0000";
  signal AddressIF, AddressID, InstructionIF, InstructionID, ReadDataOneID, readDataTwoID, PCIn, PCOut, WriteRegister, WriteRegisterData: std_logic_vector(32 downto 0) := X"00000000";
begin
  -- IF
  PC_instance: PC port map(clk, PCIn, PCOut);
  Add_instance_0: Add port map(PCOut, X"00000004", AddressIF);
  InstructionMemory_instance: InstructionMemory port map(PCOut, InstructionIF);
  IFIDRegister_instance: IFIDRegister port map(clk, AddressIF, InstructionIF, AddressID, InstructionID);
  -- ID
  Registers_instance: Registers port map(InstructionID(25 downto 21), Instruction(20 downto 16), WriteRegister, WriteRegisterData, RegWrite, clk, ReadDataOneID, ReadDataTwoID);
  PipelineControl_instance: PipelineControl port map(InstructionID(25 downto 21), ALUSrcID, BranchID, MemReadID, MemWriteID, MemtoRegID, RegDstID, RegWriteID, ALUOpID);
  IDEXRegister_instance: IDEXRegister port map(clk, BranchID, MemWriteID, MemReadID, MemtoRegID, RegDstID, RegWriteID, ALUOpID, AddressID, InstructionID, ReadDataOneID, ReadDataTwoID, BranchEX, MemWriteEX, MemReadEX, MemtoRegEX, RegDstEX, RegWriteEX, ALUOpEX, AddressEX, InstructionEX, ReadDataOneEX, ReadDataTwoEX);
  -- EX
  ALUControl_instance: ALUControl port map(ALUOpEX, InstructionEX(5 downto 0), Operation);
  ALU_instance: ALU port map();
end Behavioral;
