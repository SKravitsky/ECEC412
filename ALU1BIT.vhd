library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity ALU1BIT is
port( a,b,less,CarryIn:in STD_LOGIC;
      OPER:in STD_LOGIC_VECTOR(3 downto 0);
      Result:buffer STD_LOGIC;
      CarryOut,Set:out STD_LOGIC);
end ALU1BIT;
architecture alu_BEH of ALU1BIT is
begin
  process (a,b,CarryIn,OPER)
    begin    
      case OPER is
        when "0000"=> -- AND
            Result<=a and b;
        when "0001"=> -- OR
            Result<=a OR b;
        when "0010"=> -- ADD
            Result<=(a xor b) xor CarryIn; 
            CarryOut<= (a and b) or ((a xor b) and CarryIn);
            Set <= Result after 0 ns;
        when "0110"=> -- SUBTRACT
            Result<=(a xor (not b)) xor CarryIn; 
            --CarryOut<= ((not (A xor B)) and CarryIn) or ( (not A) or B ); --FULL SUBTRACTOR CARRY EQ.
            CarryOut<= (a and (not b)) or ((a xor (not b)) and CarryIn);
            Set <= Result after 0 ns;
        when "0111"=> -- SET on LESS than
            Result<=less;
            Set<=(a xor (not b) ) xor CarryIn;
            CarryOut<= (a and (not b)) or ((a xor (not b)) and CarryIn);
        when "1100"=> -- NOR
            Result<=a nor b;
        when others=> 
            result<='X';
      end case;
    end process;
end alu_BEH;
