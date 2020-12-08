library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_down_counter is
    generic(
        N : integer := 32
    );
    port (
        clk, rst : in  std_logic;
        i_updown : in std_logic;
        o_count : out std_logic_vector(N-1 downto 0)
    );
end entity up_down_counter;

architecture rtl of up_down_counter is

    signal r_cnt : integer range 0 to (2**N -1) := 0;

begin
    updown: process(clk, rst)
    begin
        if rst = '1' then
            r_cnt <= 0;
        elsif rising_edge(clk) then
            if i_updown = '1' then   --> up counter
                if r_cnt = (2**N -1) then 
                    r_cnt <= 0;
                else 
                    r_cnt <= r_cnt + 1;
                end if;
            elsif i_updown = '0' then --> down counter
                if r_cnt = 0 then 
                    r_cnt <= (2**N -1); -->
                else 
                    r_cnt <= r_cnt - 1;
                end if;
            end if;
        end if;
    end process updown;
    
    o_count <= std_logic_vector(to_unsigned(r_cnt,o_count'length));

end architecture rtl;