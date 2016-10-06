library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
	port (
		Address : in std_logic_vector(31 downto 0);
		ReadData : out std_logic_vector(31 downto 0)
	);
end InstructionMemory;

architecture Structural of InstructionMemory is
	type mem_array is array(0 to 31) of std_logic_vector(31 downto 0);
	signal inst_mem: mem_array := (
		0 => X"02308020", --add S0,S1,S0
		others => X"00000000"
	);
begin
	ReadData <= inst_mem(to_integer(unsigned(Address(6 downto 2))));
end Structural;
