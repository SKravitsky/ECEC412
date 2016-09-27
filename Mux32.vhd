library ieee;
use ieee.std_logic_1164.all;

entity MUX32 is
port(x,y:in std_logic_vector (31 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(31 downto 0));
end MUX32;

architecture struct of MUX32 is
begin
z <= y when sel = '1' else x;
end struct;