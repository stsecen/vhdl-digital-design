library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_latch is
    port (
        en : in std_logic;
        i_data : in  std_logic;
        o_data : out std_logic     
    );
end entity d_latch;

architecture rtl of d_latch is
    
begin
    latch: process(en,d)
    begin
        if en = '1' then
            o_data <= i_data;
        end if;
    end process latch;

end architecture rtl;