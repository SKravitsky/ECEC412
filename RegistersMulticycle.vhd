library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegistersMulticycle is
  port(
    RR1, RR2, WR: in std_logic_vector(4 downto 0);
    WD: in std_logic_vector(31 downto 0);
    RegWrite: in std_logic;
    RD1, RD2: out std_logic_vector(31 downto 0)
  );
end RegistersMulticycle;

Architecture Structural of RegistersMulticycle is
  type mem_array is array(0 to 31) of std_logic_vector(31 downto 0);
  signal reg_mem: mem_array := (
    X"00000000", --0  $zero (constant value 0)
    X"00000000", --   $at (reserved for the assembler)
    X"00000000", --   $v0 (value for results and expression)
    X"00000000", --   $v1
    X"00000000", --   $a0 (arguments)
    X"00000000", --5  $a1
    X"00000000", --   $a2
    X"00000000", --   $a3
    X"00000000", --   $t0 (temporaries)
    X"00000000", --   $t1
    X"00000000", --10 $t2
    X"00000000", --   $t3
    X"00000000", --   $t4
    X"00000000", --   $t5
    X"00000000", --   $t6
    X"00000000", --15 $t7
    X"00000000", --   $s0 (saved)
    X"00000000", --   $s1
    X"00000000", --   $s2
    X"00000000", --   $s3
    X"0000000E", --20 $s4
    X"00000005", --   $s5
    X"00000000", --   $s6
    X"00000000", --   $s7
    X"00000000", --   $t8 (more temporaries)
    X"00000000", --25 $t9
    X"00000000", --   $k0 (reserved for the operating system)
    X"00000000", --   $k1
    X"00000000", --   $gp (global pointer)
    X"00000000", --   $sp (stack pointer)
    X"00000000", --30 $fp (frame pointer)
    X"00000000"  --   $ra (return address)
  );
  signal temp_data: std_logic_vector(31 downto 0) := X"00000000";
begin
  RD1 <= reg_mem(to_integer(unsigned(RR1)));
  RD2 <= reg_mem(to_integer(unsigned(RR2)));
  process(WD, WR, RegWrite)
  begin
    if RegWrite = '1' then
      reg_mem(to_integer(unsigned(WR))) <= WD;
    end if;
  end process;
end Structural;
