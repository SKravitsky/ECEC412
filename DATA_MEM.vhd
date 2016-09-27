library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
  port  ( WriteData :in std_logic_vector(31 downto 0);
          Address   :in std_logic_vector(31 downto 0);
          MemRead,MemWrite,CLK  :in std_logic;
          ReadData  :out std_logic_vector(31 downto 0)
         );
end DataMemory;

architecture behavioral of DataMemory is

type memory_mat is array (2**8-1 downto 0) of std_logic_vector(7 downto 0);
signal mem : memory_mat := 
(         0 => "00000000",
          1 => "00000000",
          2 => "00000000",
          3 => "00000100",
    
          4 => "00000000",
          5 => "00000000",
          6 => "00000000",
          7 => "00000010",
          others => "00000000"
      );
begin
 
 process(CLK)
    variable ADD_INT:integer:=0;
  begin
  		ADD_INT:= to_integer(unsigned(Address));
  if rising_edge(CLK) then
    
      if (MemWrite = '1') then
          ReadData<="00000000000000000000000000000000";
          mem(ADD_INT) <= WriteData(31 downto 24);
          mem(ADD_INT+1) <= WriteData(23 downto 16);
          mem(ADD_INT+2) <= WriteData(15 downto 8);
          mem(ADD_INT+3) <= WriteData(7 downto 0);
      end if;
	else
      if (MemRead = '1' ) then
          ReadData <= mem(ADD_INT) & mem(ADD_INT+1) & mem(ADD_INT+2) & mem(ADD_INT+3);
      end if;
end if;
end process;
end behavioral;
        
          
