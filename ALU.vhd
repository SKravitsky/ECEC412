library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ALU is
generic(n:natural:=32);
port(a,b:in std_logic_vector(N-1 downto 0);
	   Oper:in std_logic_vector(3 downto 0);
	   Result:buffer std_logic_vector(N-1 downto 0);
	   Zero,CarryOut,Overflow:buffer std_logic);
 end ALU;


architecture NBIT_ALU_GEN of ALU is
-- COMPONENT LIST
component ALU1BIT is
port( a,b,less,CarryIn:in STD_LOGIC;
      OPER:in STD_LOGIC_VECTOR(3 downto 0);
      Result:buffer STD_LOGIC;
      CarryOut,Set:out STD_LOGIC);
end component;
component NBIT_OR is
  generic (N:Natural:=4);
  port (A:in STD_LOGIC_VECTOR(N-1 downto 0);
        Z:out STD_LOGIC);
end component;
component XOR_GATE is
  port (A, B:in STD_LOGIC; C:out STD_LOGIC);
end component;
-- SUB SIGNALS
 signal NO1:STD_LOGIC;
 signal L0:STD_LOGIC;
 signal S0:STD_LOGIC_VECTOR(N-1 downto 0) := (others=>'0');
 signal CI:STD_LOGIC;
 signal CO:STD_LOGIC_VECTOR(N-1 downto 0) := (others=>'0');
 signal OR_OUT:STD_LOGIC;
-- CONSTRUCTION
begin
  
  -- Initial signals
  L0 <= Result(N-1);
  CI <= Oper(2);
  
  --ALU Structure Signals
  ALUn:ALU1BIT port map (A(0),B(0),L0,CI,OPER,Result(0),CO(0),S0(0) );
  G1: for i in 1 to N-1 generate
      ALUi:ALU1BIT port map (A(i),B(i),'0',CO(i-1),OPER,Result(i),CO(i),S0(i) );
  end generate G1;
  
  -- CARRY Out signal.
  CarryOut <= CO(N-1);
  
  -- ZERO Out signal
  OR0:NBIT_OR generic map (N) port map (Result,OR_OUT);
  Zero<=not OR_OUT;
  
  -- OVERFLOW Signal
  XO1:XOR_GATE port map (CO(N-1),CO(N-2),Overflow);
  
  
 end NBIT_ALU_GEN;
