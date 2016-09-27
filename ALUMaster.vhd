library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUMaster is
generic(n:natural := 32);
port(a,b : in std_logic_vector(n-1 downto 0);
	  oper : in std_logic_vector(3 downto 0);
	  result : buffer std_logic_vector(n-1 downto 0);
	  zero,carryout,overflow : buffer std_logic);
end ALUMaster;

architecture struct of ALUMaster is

component ALU1
port( ALUctl : in std_logic_vector(3 downto 0);
		a,b : in std_logic;
		less,carryIn : in std_logic;
		result,carryOut : out std_logic);
end component;

component ALU1End 
port( ALUctl : in std_logic_vector(3 downto 0);
		a,b : in std_logic;
		less,carryIn : in std_logic;
		result,carryOut,set : out std_logic);
end component;

component NBIT_OR
generic (N:Natural:=32);
  port (A:in STD_LOGIC_VECTOR(N-1 downto 0);
        Z:out STD_LOGIC);
end component;

signal set,set_temp : std_logic;
signal OR_OUT:STD_LOGIC;
signal carryTemp: std_logic_vector(n-1 downto 0);
begin

G1: for i in n-1 downto 0 generate
	G2: if i = 0 generate
			UUT: ALU1 port map(oper,a(i),b(i),set,oper(2),result(i),carryTemp(i));
			end generate G2;
	G3: if i > 0 and i < n-1 generate
			UUT: ALU1 port map(oper,a(i),b(i),'0',carryTemp(i-1),result(i),carryTemp(i));
			end generate G3;
	G4: if i = n-1 generate
			UUT: ALU1End port map(oper,a(i),b(i),'0',carryTemp(i-1),result(i),carryTemp(i),set_temp);
			end generate G4;
		end generate G1;
		
		overflow <= carryTemp(31) xor carryTemp(30);
		set <= set_temp xor overflow;
		carryout <= carryTemp(31);
		ORGate : NBIT_OR port map(result,OR_OUT);
		zero <= not OR_OUT; 
end struct;