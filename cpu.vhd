library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu is
    port( clk:in std_logic;
          CarryOut, Overflow:out std_logic );
end cpu;

architecture structure of cpu is
-- COMPONENTS
component and2 is 
port( A, B: IN std_logic; Y: OUT std_logic );
end component;

component Registers is
  port(RR1,RR2,WR:in std_logic_vector(4 downto 0);
       WD:in std_logic_vector(31 downto 0);
       RegWrite,CLK:in std_logic;
       RD1,RD2:out std_logic_vector(31 downto 0));
end component;

component ALUMaster
generic(n:natural := 32);
port(a,b : in std_logic_vector(n-1 downto 0);
	  oper : in std_logic_vector(3 downto 0);
	  result : buffer std_logic_vector(n-1 downto 0);
	  zero,carryout,overflow : buffer std_logic);
end component;

component InstructionMemory is
port(Address:in std_logic_vector(31 downto 0);
     ReadData:out std_logic_vector(31 downto 0));
end component;

component DataMemory is
  port  ( WriteData :in std_logic_vector(31 downto 0);
          Address   :in std_logic_vector(31 downto 0);
          MemRead,MemWrite,CLK  :in std_logic;
          ReadData  :out std_logic_vector(31 downto 0)
         );
end component;

component MainControl is
port(
     Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
end component;

component ALUControl is
port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
end component;

component PC is
port(clk:in std_logic;
     AddressIn:in std_logic_vector(31 downto 0);
     AddressOut:out std_logic_vector(31 downto 0));
end component;

component SignExtend is
port(x:in std_logic_vector(15 downto 0);
     y:out std_logic_vector(31 downto 0));
end component;

component SHIFTLEFT2 is
  port( X:in STD_LOGIC_VECTOR(31 downto 0);
        Y:out STD_LOGIC_VECTOR(31 downto 0));
end component;

component SHIFTLEFT2JUMP is
  port( X:in STD_LOGIC_VECTOR(25 downto 0);
        Y:in STD_LOGIC_VECTOR(3 downto 0);
        Z:out STD_LOGIC_VECTOR(31 downto 0));
end component;

component MUX5 is
port(x,y:in std_logic_vector (4 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(4 downto 0));
end component;

component MUX32 is
port(x,y:in std_logic_vector (31 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(31 downto 0));
end component;

--SIGNALS
signal A,C,D,E,F,G,H,J,K,L,M,N,P,Q  :std_logic_vector(31 downto 0);
signal Instruction    :std_logic_vector(31 downto 0);
signal B,rs,rt,rd     :std_logic_vector(4 downto 0);
signal R,Zero,RegDst,Jump,Branch,MemRead,MemToReg,MemWrite,ALUSrc,RegWrite:std_logic:='0';    
signal ALUop:std_logic_vector(1 downto 0);
signal Operation:std_logic_vector(3 downto 0);
signal Op, funct:std_logic_vector(5 downto 0);
signal jimm:std_logic_vector(25 downto 0);
signal imm:std_logic_vector(15 downto 0);

begin

Op<= Instruction(31 downto 26);
jimm<=Instruction(25 downto 0);
rs <=Instruction(25 downto 21);
rt <= Instruction(20 downto 16);
rd <= Instruction(15 downto 11);
imm <= Instruction(15 downto 0);
funct<=Instruction(5 downto 0);

--Instantiate instruction memory
IM : InstructionMemory port map(A,Instruction);
--Instantiate registers mux
RegMUX : MUX5 port map(rt,rd,RegDst,B);
--Instantiate registers
Regs : Registers port map(rs,rt,B,J,RegWrite,Clk,C,D);
--Instantiate the control
Control : MainControl port map(Op,RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump,ALUOp);
--Instantiate sign extend
SE : SignExtend port map(imm,E);
--Instantiate ALU mux
ALUmux : MUX32 port map(D,E,ALUSrc,F);
--Instantiate ALU Control
ALUCon : ALUControl port map(ALUOp,funct,Operation);
--Instantiate data memory
DataMem : DataMemory port map(D,G,MemRead,MemWrite,Clk,H);
--Instantiate memory mux
DataMUX : MUX32 port map(G,H,MemtoReg,J);
--Instantiate the PC
programCounter : PC port map(clk,P,A);
--Instantiate PC adder
pcAdder : ALUMaster port map(A,"00000000000000000000000000000100","0010",L,open,open,open);
--Instantiate the ShiftLeft2 jump
shiftLeftJump : ShiftLeft2Jump port map(jimm, L(31 downto 28),Q);
--Instantiate the branch adder
branchAdder : ALUMaster port map(L,K,"0010",M,open,open,open);
--Instantiate the branch shift left 2
shiftLeftBranch : ShiftLeft2 port map(E,K);
--Instantiate the AND gate
zeroAND : AND2 port map(Branch,Zero,R);
--Instantiate the branch mux
branchMux : MUX32 port map(L,M,R,N);
--Instantiate the jump mux
jumpMux : MUX32 port map(N,Q,Jump,P);
--Instantiate the ALU
ALU : ALUMaster port map(C,F,Operation,G,Zero,CarryOut,Overflow);  

end structure;

