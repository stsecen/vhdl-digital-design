library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
    port (
        --> inputs
        i_data0 : in std_logic;
        i_data1 : in std_logic;
        i_sel   : in std_logic;
        --> output 
        o_data  : out std_logic
    );
end entity mux2;

architecture rtl of mux2 is
    
begin
    
    with i_sel select 
    o_data  <=  i_data0 when '0',
                i_data1 when '1',
                '0' when others;
    
end architecture rtl;

architecture behavioral of mux2 is
    
begin

    o_data <= (i_data0 and not(i_sel)) or (i_data1 and i_sel);

end architecture behavioral;