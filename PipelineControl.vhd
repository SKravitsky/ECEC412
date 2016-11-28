library ieee;
use ieee.std_logic_1164.all;

entity PipelineControl is
  port(
    Opcode: in std_logic_vector(5 downto 0);
    ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegDst, RegWrite: out std_logic;
    ALUOp: out std_logic_vector(1 downto 0)
  );
end PipelineControl;

architecture Structural of PipelineControl is
begin
  process(Opcode)
  begin
    case Opcode is
      when "000000" => --add/sub
        RegDst <= '1';
        Branch <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        MemWrite <= '0';
        ALUSrc <= '0';
        RegWrite <= '1';
        ALUOp <= "10";
      when "100011" => --lw
        RegDst <= '0';
        Branch <= '0';
        MemRead <= '1';
        MemtoReg <= '1';
        MemWrite <= '0';
        ALUSrc <= '1';
        RegWrite <= '1';
        ALUOp <= "00";
      when "000100" => --beq
        RegDst <= '0';
        Branch <= '1';
        MemRead <= '0';
        MemtoReg <= '0';
        MemWrite <= '0';
        ALUSrc <= '0';
        RegWrite <= '0';
        ALUOp <= "01";
      when "000010" => --j
        RegDst <= '0';
        Branch <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        MemWrite <= '0';
        ALUSrc <= '0';
        RegWrite <= '0';
        ALUOp <= "00";
      when "101011" => --sw
        RegDst <= '0';
        Branch <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        MemWrite <= '1';
        ALUSrc <= '1';
        RegWrite <= '0';
        ALUOp <= "00";
      when others =>
        null;
  end case;
  end process;
end Structural;
