library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter is
    generic(M: integer := 5;
            N: integer := 32);
    port (
        i_data0  : in std_logic_vector(N-1 downto 0);
        i_rotate : in std_logic;
        i_shift  : in std_logic_vector(M-1 downto 0);
        o_data0  : out std_logic_vector(N-1 downto 0)
    );
end entity barrel_shifter;

architecture rtl of barrel_shifter is
    
begin
    
    barrel00: process(i_data0, i_rotate, i_shift)

        variable v : integer range 0 to N-1 := 0; 

    begin

        v := to_integer(unsigned(i_shift));
        if v /= 0 then 
            if i_rotate = '0' then -- right shift 
                o_data0 <= std_logic_vector(shift_right(unsigned(i_data0),v));
            else                   -- left shift
                o_data0 <= std_logic_vector(shift_left(unsigned(i_data0),v));
            end if; 
        else 
            o_data0 <= i_data0;
        end if;

    end process barrel00;
    
end architecture rtl;