library ieee;
use ieee.std_logic_1164.all;

entity MUX5 is
port(x,y:in std_logic_vector (4 downto 0);
     sel:in std_logic;
     z:out std_logic_vector(4 downto 0));
end MUX5;

architecture struct of MUX5 is
begin
z <= y when sel = '1' else x;
end struct;