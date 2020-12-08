library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        --> inputs 
        a,b,ci: in std_logic;
        --> outputs
        s,co: out std_logic     
    );
end entity full_adder;

architecture behavioral of full_adder is
begin

    s <= a xor b xor c;
    co <= (a and b) or (a and ci) or (b and ci);
    
end architecture behavioral;

architecture structural of full_adder is

    --> intermediate signals 
    signal s0,s1,s2 : std_logic;

    component half_adder is
        port(
            a,b: in std_logic;
            s,c: out std_logic
        );
    end component;
    
begin
    
    h0: half_adder port map(a=>a, b=>b, s=>s0, c=>s1);
    h1: half_adder port map(a=>s0, b=>ci, s=>s, c=>s2);
    co <= s1 or s2;
    
end architecture structural;