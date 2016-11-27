library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MulticycleControl is
  port(
    Opcode: in std_logic_vector(5 downto 0);
    clk: in std_logic;
    RegDst, RegWrite, ALUSrcA, IRWrite, MemtoReg, MemWrite, MemRead, IorD, PCWrite, PCWriteCond: out std_logic;
    ALUSrcB, ALUOp, PCSource: out std_logic_vector(1 downto 0)
  );
end MulticycleControl;

architecture Structural of MulticycleControl is
  signal reset: std_logic := '0';
  signal memWriteLatch: std_logic := '0';
  signal regWriteLatch: std_logic := '0';
begin
  process(clk)
    variable state: integer := 0;
  begin
    case state is
      -- IF
      when 0 =>
        MemRead <= '1';
        memWriteLatch <= '0';
        MemtoReg <= '0';
        ALUSrcA <= '0';
        IorD <= '0';
        IRWrite <= '1';
        ALUSrcB <= "01";
        ALUOp <= "00";
        regWriteLatch <= '0';
        RegDst <= '0';
        PCWrite <= '1';
        PCWriteCond <= '0';
        PCSource <= "00";
      -- ID
      when 1 =>
        ALUSrcA <= '0';
        ALUSrcB <= "11";
        ALUOp <= "00";
        PCWrite <= '0';
        IRWrite <= '0';
      -- EX
      when 2 =>
        case Opcode is
          -- R-Type
          when "000000" =>
            ALUSrcA <= '1';
            ALUSrcB <= "00";
            ALUOp <= "10";
          -- LW/SW
          when "100011" | "101011" =>
            ALUSrcA <= '1';
            ALUSrcB <= "10";
            ALUOp <= "00";
          -- BEQ
          when "000100" =>
            ALUSrcA <= '1';
            ALUSrcB <= "00";
            ALUOp <= "01";
            PCWriteCond <= '1';
            PCSource <= "01";
            reset <= '1';
          -- J
          when "000010" =>
            PCWrite <= '1';
            PCSource <= "10";
            reset <= '1';
          when others =>
            null;
        end case;
      -- MEM
      when 3 =>
        case Opcode is
          -- R-Type
          when "000000" =>
            RegDst <= '1';
            regWriteLatch <= '1';
            MemtoReg <= '0';
            reset <= '1';
          -- LW
          when "100011" =>
            MemRead <= '1';
            IorD <= '1';
          -- SW
          when "101011" =>
            memWriteLatch <= '1';
            IorD <= '1';
          when others =>
            null;
        end case;
      -- WB
      when 4 =>
        case Opcode is
          -- LW
          when "100011" =>
            regWriteLatch <= '1';
            MemtoReg <= '1';
            RegDst <= '0';
          when others =>
            null;
        end case;
      when others =>
        null;
    end case;

    if falling_edge(clk) then
      if memWriteLatch='1' then
        MemWrite <= '1';
      end if;
      if regWriteLatch='1' then
        RegWrite <= '1';
      end if;
      if state = 4 or reset = '1' then
        -- Wrap back from WB to IF
        state := 0;
        reset <= '0';
      else
        -- Proceed to next stage
        state := state + 1;
      end if;
    end if;

    if rising_edge(clk) then
      MemWrite <= '0';
      RegWrite <= '0';
    end if;
  end process;
end Structural;
