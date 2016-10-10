library ieee;
use ieee.std_logic_1164.all;

entity CPU is
  port(
    clk: in std_logic;
    Overflow: out std_logic
  );
end CPU;

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

  component SignExtend
    port(
      x: in std_logic_vector(15 downto 0);
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component ShiftLeft2
    port(
      x: in std_logic_vector(31 downto 0);
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component ShiftLeft2Jump
    port(
      x: in std_logic_vector(25 downto 0);
      y: in std_logic_vector(3 downto 0);
      z: out std_logic_vector(31 downto 0)
    );
  end component;

  component Mux5
    port(
      x, y: in std_logic_vector (4 downto 0);
      sel: in std_logic;
      z :out std_logic_vector(4 downto 0)
    );
  end component;

  component Mux32
    port(
      x, y: in std_logic_vector (31 downto 0);
      sel: in std_logic;
      z: out std_logic_vector(31 downto 0)
    );
  end component;

  component And2
  	port(
  		a, b: in std_logic;
  		y: out std_logic
  	);
  end component;

  component ALU
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

  component Registers
    port(
      RR1, RR2, WR: in std_logic_vector(4 downto 0);
      WD: in std_logic_vector(31 downto 0);
      RegWrite, Clk: in std_logic;
      RD1, RD2: out std_logic_vector(31 downto 0)
    );
  end component;

  component InstructionMemory
    port (
      Address: in std_logic_vector(31 downto 0);
      ReadData: out std_logic_vector(31 downto 0)
    );
  end component;

  component DataMemory
    port(
      WriteData: in std_logic_vector(31 downto 0);
      Address: in std_logic_vector(31 downto 0);
      Clk, MemRead, MemWrite: in std_logic;
      ReadData: out std_logic_vector(31 downto 0)
    );
  end component;

  component ALUControl
  	port(
  		ALUOp: in std_logic_vector(1 downto 0);
  		Funct: in std_logic_vector(5 downto 0);
  		Operation: out std_logic_vector(3 downto 0)
  	);
  end component;

  component Control
    port(
      Opcode: in std_logic_vector(5 downto 0);
      RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump: out std_logic;
      ALUOp: out std_logic_vector(1 downto 0)
    );
  end component;
  signal RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, R, Zero, CarryOut: std_logic := '0';
  signal AlUOp: std_logic_vector(1 downto 0) := "00";
  signal Operation: std_logic_vector(3 downto 0) := "0000";
  signal B: std_logic_vector(4 downto 0) := "00000";
  signal A, C, D, E, F, G, H, J, L, K, M, N, P, Q, Instruction: std_logic_vector(31 downto 0) := X"00000000";
begin
  PC_instance: PC port map(clk, P, A);
  Add_instance_0: Add port map(A, X"00000004", L);
  Add_instance_1: Add port map(L, K, M);
  SignExtend_instance: SignExtend port map(Instruction(15 downto 0), E);
  ShiftLeft2_instance: ShiftLeft2 port map(E, K);
  ShiftLeft2Jump_instance: ShiftLeft2Jump port map(Instruction(25 downto 0), L(31 downto 28), Q);
  Mux5_instance: Mux5 port map(Instruction(20 downto 16), Instruction(15 downto 11), RegDst, B);
  Mux32_instance_0: Mux32 port map(L, M, R, N);
  Mux32_instance_1: Mux32 port map(N, Q, Jump, P);
  Mux32_instance_2: Mux32 port map(D, E, ALUSrc, F);
  Mux32_instance_3: Mux32 port map(G, H, MemToReg, J);
  And2_instance: And2 port map(Branch, Zero, R);
  ALU_instance: ALU port map(C, F, Operation, G, Zero, CarryOut, Overflow);
  Registers_instance: Registers port map(Instruction(25 downto 21), Instruction(20 downto 16), B, J, RegWrite, clk, C, D);
  InstructionMemory_instance: InstructionMemory port map(A, Instruction);
  DataMemory_instance: DataMemory port map(D, G, clk, MemRead, MemWrite, H);
  ALUControl_instance: ALUControl port map(ALUOp, Instruction(5 downto 0), Operation);
  Control_instance: Control port map(Instruction(31 downto 26), RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump, ALUOp);
end Behavioral;
