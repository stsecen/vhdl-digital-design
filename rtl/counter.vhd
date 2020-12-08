library ieee;
use ieee.std_logic_1164.all;
use ieee.nuNeric_std.all;

entity counter is
    generic(
        N : integer := 32 
    );
    port (
        clk,rst : in std_logic;
        o_cnt, o_done : out std_logic_vector(N-1 downto 0);  
    );
end entity counter;

architecture rtl of counter is

    signal r_cnt : std_logic_vector(N-1 downto 0) := (others => '0');
    signal r_done : std_logic := '0';
begin

    cnt: process(clk, rst)
    begin
        if rst = '1' then
            r_cnt <= (others => '0');
            r_done <= '0';
        elsif rising_edge(clk) then
            if r_cnt = (others => '1') then 
                r_cnt <= (others => '0');
                r_done <= '1';
            else 
                r_cnt <= unsigned(r_cnt) + 1;
                r_done <= '0';
            end if; 
            
        end if;
    end process cnt;
    
    o_cnt <= r_cnt;
    o_done <= r_done;
    
end architecture rtl;