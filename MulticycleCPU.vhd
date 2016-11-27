library ieee;
use ieee.std_logic_1164.all;

entity MulticycleCPU is
  port(
    clk: in std_logic;
    CarryOut, Overflow: out std_logic
  );
end MulticycleCPU;

architecture Behavioral of MulticycleCPU is
  component PCMulticycle is
    port(
      clk, d: in std_logic;
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

  component Or2 is
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

  component IR is
    port (
      x: in std_logic_vector(31 downto 0);
      clk, IRWrite: in std_logic;
      y: out std_logic_vector(31 downto 0)
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

  component RegA is
    port(
      x: in std_logic_vector(31 downto 0);
      clk: in std_logic;
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component RegB is
    port(
      x: in std_logic_vector(31 downto 0);
      clk: in std_logic;
      y: out std_logic_vector(31 downto 0)
    );
  end component;

  component InstructionMemory
    port (
      Address: in std_logic_vector(31 downto 0);
      ReadData: out std_logic_vector(31 downto 0)
    );
  end component;

  component MDR is
    port (
      x: in std_logic_vector(31 downto 0);
      clk: in std_logic;
      y: out std_logic_vector(31 downto 0)
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

  component ALUControl
  	port(
  		ALUOp: in std_logic_vector(1 downto 0);
  		Funct: in std_logic_vector(5 downto 0);
  		Operation: out std_logic_vector(3 downto 0)
  	);
  end component;

  component MUX3Way is
    port(
      w, x, y: in std_logic_vector(31 downto 0);
      sel: in std_logic_vector(1 downto 0);
      z:out std_logic_vector(31 downto 0)
    );
  end component;

  component MUX4Way is
    port(
      v, w, x, y: in std_logic_vector(31 downto 0);
      sel: in std_logic_vector(1 downto 0);
      z:out std_logic_vector(31 downto 0)
    );
  end component;

  component MulticycleControl is
    port(
      Opcode: in std_logic_vector(5 downto 0);
      clk: in std_logic;
      RegDst, RegWrite, ALUSrcA, IRWrite, MemtoReg, MemWrite, MemRead, IorD, PCWrite, PCWriteCond: out std_logic;
      ALUSrcB, ALUOp, PCSource: out std_logic_vector(1 downto 0)
    );
  end component;

  signal D, PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst, Zero, W: std_logic := '0';
  signal ALUOp, ALUSrcB, PCSource: std_logic_vector(1 downto 0) := "00";
  signal Operation: std_logic_vector(3 downto 0) := "0000";
  signal K: std_logic_vector(4 downto 0) := "00000";
  signal C, E, F, G, H, I, J, L, M, N, P, Q, R, S, T, U, V, Instruction: std_logic_vector(31 downto 0) := X"00000000";
begin
  PC_instance: PCMulticycle port map(clk, D, C, E);
  Mux32_instance_0: Mux32 port map(E, F, IorD, G);
  DataMemory_instance: DataMemoryMulticycle port map(H, G, MemRead, MemWrite, I);
  IR_instance: IR port map(I, clk, IRWrite, Instruction);
  Mux5_instance: Mux5 port map(Instruction(20 downto 16), Instruction(15 downto 11), RegDst, K);
  MDR_instance: MDR port map(I, clk, J);
  Mux32_instance_1: Mux32 port map(F, J, MemtoReg, L);
  Registers_instance: RegistersMulticycle port map(Instruction(25 downto 21), Instruction(20 downto 16), K, L, RegWrite, M, N);
  RegA_instance: RegA port map(M, clk, P);
  RegA_instance_2: RegA port map(N, clk, H);
  SignExtend_instance: SignExtend port map(Instruction(15 downto 0), Q);
  ShiftLeft2_instance: ShiftLeft2 port map(Q, R);
  MUX4Way_instance: MUX4Way port map(H, X"00000004", Q, R, ALUSrcB, T);
  Mux32_instance_2: Mux32 port map(E, P, ALUSrcA, S);
  ShiftLeft2Jump_instance: ShiftLeft2Jump port map(Instruction(25 downto 0), E(31 downto 28), V);
  MUX3Way_instance: MUX3Way port map(U, F, V, PCSource, C);
  And2_instance: And2 port map(Zero, PCWriteCond, W);
  Or2_instance: Or2 port map(W, PCWrite, D);
  ALU_instance: ALU port map(S, T, Operation, U, Zero, Carryout, Overflow);
  ALUControl_instance: ALUControl port map(ALUOp, Instruction(5 downto 0), Operation);
  ALUOut: RegB port map(U, clk, F);
  Control_instance: MulticycleControl port map(Instruction(31 downto 26), clk, RegDst, RegWrite, ALUSrcA, IRWrite, MemtoReg, MemWrite, MemRead, IorD, PCWrite, PCWriteCond, ALUSrcB, ALUOp, PCSource);
end Behavioral;
