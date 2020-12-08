library ieee;
use ieee.std_logic_1164.all;

entity hexto7segment is
    port (
        i_hex : in std_logic_vector(3 downto 0);
        o_seven : out std_logic_vector(6 downto 0)
    );
end entity hexto7segment;

architecture rtl of hexto7segment is
    
begin
    
    with i_hex select 
        o_seven <=  "0111111" when "0000", --> 0 active high outputs
                    "0000110" when "0001", --> 1
                    "1011011" when "0010", --> 2
                    "1001111" when "0011", --> 3 
                    "1100110" when "0100", --> 4
                    "1101101" when "0101", --> 5
                    "1111101" when "0110", --> 6
                    "0000111" when "0111", --> 7
                    "1111111" when "1000", --> 8
                    "1101111" when "1001", --> 9
                    "1110111" when "1010", --> a
                    "1111100" when "1011", --> b
                    "0111001" when "1100", --> c
                    "1011110" when "1101", --> d
                    "1111001" when "1110", --> e
                    "1110001" when "1111"; --> f
                    "0000000" when others;

end architecture rtl;