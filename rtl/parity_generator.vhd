library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parity_generator is
    generic(N: integer := 64);
    port (
        i_data0 : in std_logic_vector(N-1 downto 0);
        i_odd   : in std_logic;
        o_parity : out std_logic
    );
end entity parity_generator;

architecture rtl of parity_generator is

begin

    pargen: process(i_data0, i_odd)
    variable v_par: std_logic;
    begin    
        v_par <= '0';  
        for jj in i_data0'range loop
            v_par <= v_par xor i_data0(jj);
        end loop; 
        o_parity <= v_par xor i_odd; --> odd parity for i_odd is 1 and even paritu for i_odd is 0 
    end process pargen;
    
end architecture rtl;