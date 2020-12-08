library ieee;
use ieee.std_logic_1164.all;

entity d_flipflop is
    port (
        clk : in std_logic;
        rst : in std_logic;
        j,k : in std_logic; 
        o_data : out std_logic;
        o_datanot : out std_logic
    );
end entity d_flipflop;

architecture rtl of d_flipflop is
    signal r_q : std_logic;
begin
    
    proc_name: process(clk, rst)
    begin
        if (rst = '1') then 
            r_q <= '0';
        elsif rising_edge(clk) then
            if (j= '0' and k = '0') then 
                r_q <= r_q;
            elsif (j= '0' and k = '1') then 
                r_q <= '0';
            elsif (j= '1' and k = '0') then 
                r_q <= '1';
            elsif (j= '1' and k = '1') then 
                r_q <= not(r_q);
            end if;
        end if;
    end process proc_name;

    o_data <= r_q;
    o_datanot <= not(r_q);
    
end architecture rtl;