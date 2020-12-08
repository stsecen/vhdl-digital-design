library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry_adder is
    generic(N: integer := 64);
    port (
        --> inputs 
        i_dataA,i_dataB : in std_logic_vector(N-1 downto 0);
        i_carry : in std_logic;
        --> outputs 
        o_sum : out std_logic_vector(N-1 downto 0);
        o_carry : out std_logic
    );
end entity ripple_carry_adder;

architecture rtl of ripple_carry_adder is

    component full_adder is
        port (
            a,b,ci: in std_logic;
            s,co: out std_logic     
        );
    end component;
    
    signal s_carry: std_logic_vector(N downto 0);

begin
--
    s_carry(0) <= i_carry;
    --
    rca_gen: for j in 0 to N-1 generate
        fa: full_adder port map(
            a=>i_dataA(j), 
            b=>i_dataB(j), 
            ci=>s_carry(j),
            s=>o_sum(j), 
            co=>s_carry(j+1)
        ); 
    end generate rca_gen;
    --
    o_carry <= s_carry(N);
--   
end architecture rtl;