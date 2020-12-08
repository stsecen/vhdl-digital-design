library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (
        --> inputs 
        a,b: in std_logic;
        --> outputs
        s,c: out std_logic
    );
end entity half_adder;

architecture behavioral of half_adder is
    
begin
    
    s <= a xor b; --> sum bit
    c <= a and b; --> carry bit
    
end architecture behavioral;