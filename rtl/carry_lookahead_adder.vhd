library ieee;
use ieee.std_logic_1164.all;

entity carry_lookahead_adder is
    generic(N: integer := 64);
    port (
        --> inputs 
        i_dataA,i_dataB : in std_logic_vector(N-1 downto 0);
        i_carry : in std_logic;
        --> outputs 
        o_sum : out std_logic_vector(N-1 downto 0);
        o_carry : out std_logic
    );
end entity carry_lookahead_adder;

architecture rtl of carry_lookahead_adder is
    signal s_carry : std_logic_vector(N downto 0);
    signal s_propagated : std_logic_vector(N-1 downto 0);
    signal s_generated : std_logic_vector(N-1 downto 0);
    component full_adder is
        port (
            a,b,ci: in std_logic;
            s,co: out std_logic     
        );
    end component;
begin

    
    s_carry(0) <= i_carry;

    --> generated block for Carries  
    carry_gen: for j in 0 to N-1 generate
        s_carry(j+1) <= s_generated(j) or (s_propagated(j) and s_carry(j));
    end generate carry_gen;
    
    --> G and P  
    s_propagated <= i_dataA xor i_dataB;
    s_generated <= i_dataA and i_dataB;

    --> Output assignments  
    gen_fa: for jj in 0 to N-1 generate
        fa: full_adder port map(
            a=>i_dataA(jj), 
            b=>i_dataB(jj), 
            ci=>s_carry(jj),
            s=>o_sum(jj), 
            co=>open
        );
    end generate gen_fa;

    o_carry <= s_carry(N);
end architecture rtl;