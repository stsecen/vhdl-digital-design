library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_generator is
    generic(
        M : integer := 100
    );
    port (
        clk, rst : in  std_logic;
        o_pulse : out std_logic
    );
    end pulse_generator;

architecture rtl of pulse_generator is

    signal r_cnt : integer range 0 to M := 0;
    signal r_pulse : std_logic;

begin

    pulse_gen: process(clk, rst)
    begin
        if rst = '1' then
            r_cnt <= 0;
            r_pulse <= '0';
        elsif rising_edge(clk) then
            r_pulse <= '0';
            if r_cnt = M then 
                r_pulse <= '1';
                r_cnt <= 0;
            else 
                r_cnt <= r_cnt + 1;
            end if;    
        end if;
    end process pulse_gen;

    o_pulse <= r_pulse;

end rtl;