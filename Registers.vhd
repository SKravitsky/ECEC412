library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers is
port(RR1,RR2,WR : in std_logic_vector(4 downto 0);
		WD : in std_logic_vector(31 downto 0);
		RegWrite,CLK : in std_logic;
		RD1,RD2 : out std_logic_vector(31 downto 0));
end Registers;

architecture behav of Registers is
type regs_array is array (31 downto 0) of std_logic_vector(31 downto 0);
signal regs_temp : regs_array := (8 => "00000000000000000000000000000100", 18 =>"00000000000000000000000000001101",
        19=>"00000000000000000000000000000100",others => "00000000000000000000000000000000");
begin

process(CLK)
  variable WR_temp : integer;
begin
if rising_edge(CLK) then
	if RegWrite = '1' then
		WR_temp := conv_integer(unsigned(WR));
		if (WR_temp /= 0) then
			regs_temp(WR_temp) <= WD;
		end if;
	end if;
end if;		
	RD1 <= regs_temp(conv_integer(unsigned(RR1)));
	RD2 <= regs_temp(conv_integer(unsigned(RR2)));
end process;

end behav;

