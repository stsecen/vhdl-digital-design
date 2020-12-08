library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hamming_distance is
    generic(N: integer := 64);
    port (
        i_data0 : in std_logic_vector(N-1 downto 0);
        i_data1 : in std_logic_vector(N-1 downto 0);
        o_dist  : out std_logic_vector(9 downto 0)
    );
end entity hamming_distance;

architecture rtl of hamming_distance is

    function hamming (s0: std_logic_vector(N-1 downto 0); s1: std_logic_vector(N-1 downto 0)) return std_logic_vector is
        variable diff : std_logic_vector(N-1 downto 0);
        variable count : natural range 0 to 2**N := 0;
    begin 
        diff := s0 xor s1;
        for ii in 0 to diff'left loop
            if diff(ii) = '1' then 
                count := count + 1; 
            else 
                count := count + 0;
            end if;
        end loop; 
        diff := std_logic_vector(to_unsigned(count,10));
        return diff;
    end function;
begin

    o_dist <= hamming(i_data0, i_data1); --using function-- 
    
end architecture rtl;