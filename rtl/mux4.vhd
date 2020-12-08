library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
    port (
        i_data0 : in std_logic_vector(3 downto 0);
        i_sel : in std_logic_vector(2 downto 0);
        --> output 
        o_data : out std_logic
    );
end entity mux4;

architecture rtl of mux4 is
    
begin
    
    with i_sel select 
    o_data <=   i_data0(0) when "00",
                i_data0(1) when "01",
                i_data0(2) when "10",
                i_data0(3) when "11",
                '0' when others;
end architecture rtl;

architecture behavioral of mux4 is
    
begin

    o_data <= (i_sel(1) and i_sel(0) and i_data(3)) or (i_sel(1) and not(i_sel(0)) and i_data(2)) 
            or (not(i_sel(1)) and i_sel(0) and i_data(1)) or (not(i_sel(1)) and not(i_sel(0)) and i_data(0));

end architecture behavioral;

architecture structural of mux4 is
    
    signal s_0, s_1: std_logic;

begin

    --> 4-1 mux with using three 2-1 muxes 

    1st_mux: entity work.mux2(behavioral) 
            port map(
                i_data0 => i_data0(0),
                i_data1 => i_data0(1),
                i_sel   => i_sel(0),
                o_data  => s_0
    );
    2nd_mux: entity work.mux2(behavioral) 
            port map(
                i_data0 => i_data0(2),
                i_data1 => i_data0(3),
                i_sel   => i_sel(0),
                o_data  => s_1
    );
    3rd_mux: entity work.mux2(behavioral) 
            port map(
                i_data0 => s_0,
                i_data1 => s_1,
                i_sel   => i_sel(1),
                o_data  => o_data
    );

end architecture structural;