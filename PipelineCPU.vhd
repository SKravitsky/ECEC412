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

  component RegistersMulticycle is
    port(
      RR1, RR2, WR: in std_logic_vector(4 downto 0);
      WD: in std_logic_vector(31 downto 0);
      RegWrite: in std_logic;
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
      AddressIn, InstructionIn, ReadDataOneIn, ReadDataTwoIn: std_logic_vector(31 downto 0);
      BranchOut, MemWriteOut, MemReadOut, MemtoRegOut, RegDstOut, RegWriteOut: out std_logic;
      ALUOpOut: out std_logic_vector(1 downto 0);
      AddressOut, InstructionOut, ReadDataOneOut, ReadDataTwoOut: out std_logic_vector(31 downto 0)
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

  component Mux5 is
    port(
      x, y: in std_logic_vector (4 downto 0);
      sel: in std_logic;
      z: out std_logic_vector(4 downto 0)
    );
  end component;

  component EXMEMRegister is
    port(
      clk, BranchIn, MemWriteIn, MemReadIn, MemtoRegIn, RegWriteIn, ZeroIn: in std_logic;
      WriteRegisterIn: in std_logic_vector(4 downto 0);
      AddressIn, ALUResultIn, WriteDataIn: in std_logic_vector(31 downto 0);
      BranchOut, MemWriteOut, MemReadOut, MemtoRegOut, RegWriteOut, ZeroOut: out std_logic;
      WriteRegisterOut: out std_logic_vector(4 downto 0);
      AddressOut, ALUResultOut, WriteDataOut: out std_logic_vector(31 downto 0)
    );
  end component;

  component DataMemoryMulticycle is
    port(
      WriteData: in std_logic_vector(31 downto 0);
      Address: in std_logic_vector(31 downto 0);
      MemRead, MemWrite: in std_logic;
      ReadData: out std_logic_vector(31 downto 0)
    );
  end component;

  component MEMWBRegister is
    port(
      clk, MemtoRegIn, RegWriteIn: in std_logic;
      WriteRegisterIn: in std_logic_vector(4 downto 0);
      ReadDataIn, ALUResultIn: in std_logic_vector(31 downto 0);
      MemtoRegOut, RegWriteOut: out std_logic;
      WriteRegisterOut: out std_logic_vector(4 downto 0);
      ReadDataOut, ALUResultOut: out std_logic_vector(31 downto 0)
    );
  end component;

  -- Signals
  -- IF
  signal AddressIF, InstructionIF, PCIn, PCOut: std_logic_vector(31 downto 0) := X"00000000";
  -- ID
  signal ALUSrcID, BranchID, MemReadID, MemWriteID, MemtoRegID, RegDstID, RegWriteID: std_logic := '0';
  signal ALUOpID: std_logic_vector(1 downto 0) := "00";
  signal AddressID, InstructionID, ReadDataOneID, ReadDataTwoID: std_logic_vector(31 downto 0) := X"00000000";
  -- EX
  signal ALUSrcEX, BranchEX, MemReadEX, MemWriteEX, MemtoRegEX, RegDstEX, RegWriteEX, ZeroEX: std_logic := '0';
  signal ALUOpEX: std_logic_vector(1 downto 0) := "00";
  signal Operation: std_logic_vector(3 downto 0) := "0000";
  signal WriteRegisterEX: std_logic_vector(4 downto 0) := "00000";
  signal AddressEX, ALUOperand, ALUResultEX, InstructionEX, MaskedInstruction, ReadDataOneEX, ReadDataTwoEX: std_logic_vector(31 downto 0) := X"00000000";
  -- MEM
  signal PCSrc, BranchMEM, MemWriteMEM, MemReadMEM, MemtoRegMEM, RegWriteMEM, ZeroMEM: std_logic := '0';
  signal WriteRegisterMEM: std_logic_vector(4 downto 0) := "00000";
  signal AddressMEM, ALUResultMEM, ReadDataMEM, WriteDataMEM: std_logic_vector(31 downto 0) := X"00000000";
  -- WB
  signal MemtoRegWB, RegWriteWB: std_logic := '0';
  signal WriteRegisterWB: std_logic_vector(4 downto 0) := "00000";
  signal ALUResultWB, ReadDataWB, WriteRegisterData: std_logic_vector(31 downto 0) := X"00000000";
begin
  -- Components
  -- IF
  Mux32_instance_0: Mux32 port map(AddressIF, AddressMEM, PCSrc, PCOut);
  PC_instance: PC port map(clk, PCIn, PCOut);
  Add_instance_0: Add port map(PCOut, X"00000004", AddressIF);
  InstructionMemory_instance: InstructionMemory port map(PCOut, InstructionIF);
  IFIDRegister_instance: IFIDRegister port map(clk, AddressIF, InstructionIF, AddressID, InstructionID);
  -- ID
  Registers_instance: RegistersMulticycle port map(InstructionID(25 downto 21), InstructionID(20 downto 16), WriteRegisterWB, WriteRegisterData, RegWriteWB, ReadDataOneID, ReadDataTwoID);
  PipelineControl_instance: PipelineControl port map(InstructionID(5 downto 0), ALUSrcID, BranchID, MemReadID, MemWriteID, MemtoRegID, RegDstID, RegWriteID, ALUOpID);
  IDEXRegister_instance: IDEXRegister port map(clk, BranchID, MemWriteID, MemReadID, MemtoRegID, RegDstID, RegWriteID, ALUOpID, AddressID, InstructionID, ReadDataOneID, ReadDataTwoID, BranchEX, MemWriteEX, MemReadEX, MemtoRegEX, RegDstEX, RegWriteEX, ALUOpEX, AddressEX, InstructionEX, ReadDataOneEX, ReadDataTwoEX);
  -- EX
  ALUControl_instance: ALUControl port map(ALUOpEX, InstructionEX(5 downto 0), Operation);
  MaskedInstruction <= InstructionEX and X"0000FFFF";
  Mux32_instance_1: Mux32 port map(ReadDataTwoEX, MaskedInstruction, ALUSrcEX, ALUOperand);
  ALU_instance: ALU port map(ReadDataOneEX, ALUOperand, Operation, ALUResultEX, ZeroEX);
  Mux5_instance: Mux5 port map(InstructionEX(20 downto 16), InstructionEX(15 downto 11), RegDstEX, WriteRegisterEX);
  EXMEMRegister_instance: EXMEMRegister port map(clk, BranchEX, MemWriteEX, MemReadEX, MemtoRegEX, RegWriteEX, ZeroEX, WriteRegisterEX, AddressEX, ALUResultEX, ReadDataTwoEX, BranchMEM, MemWriteMEM, MemReadMEM, MemtoRegMEM, RegWriteMEM, ZeroMEM, WriteRegisterMEM, AddressMEM, ALUResultMEM, WriteDataMEM);
  -- MEM
  PCSrc <= BranchMEM and ZeroMEM;
  DataMemory_instance: DataMemoryMulticycle port map(WriteDataMEM, AddressMEM, MemReadMEM, MemWriteMEM, ReadDataMEM);
  MEMWBRegister_instance: MEMWBRegister port map(clk, MemtoRegMEM, RegWriteMEM, WriteRegisterMEM, ReadDataMEM, ALUResultMEM, MemToRegWB, RegWriteWB, WriteRegisterWB, ReadDataWB, ALUResultWB);
  -- WB
  Mux32_instance_2: Mux32 port map(ALUResultWB, ReadDataWB, MemtoRegWB, WriteRegisterData);
end Behavioral;
