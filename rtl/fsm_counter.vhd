library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_counter is
    generic(
        M : integer := 31;
        N : integer := 5
    );
    port(
        clk,rst  : in std_logic;
        o_count  : out std_logic_vector(N-1 downto 0)
    );
    end fsm_counter;

architecture rtl of fsm_counter is
    type state_type is (s0, s1); --> s0 for start state' s1 for count state
    signal state_reg, state_next : state_type;
    signal cnt_reg, cnt_next : integer range 0 to M; 
begin

    state_register: process(clk, rst)
    begin
        if rst = '1' then
            state_reg <= s0; 
            cnt_reg <= 0;
        elsif rising_edge(clk) then
            state_reg <= state_next;
            cnt_reg <= cnt_next;
        end if;
    end process state_register;

    nxt_state: process(state_reg,cnt_reg)
    begin
        case state_reg is
            when s0 =>
                cnt_next <= 0;
                state_next <= s1; 
            when s1 =>
                cnt_next <= cnt_reg +1; 
                if (cnt_reg /= M) then
                    state_next <= s1;
                else 
                    state_next <= s0;
                end if;     
        end case;
    end process nxt_state;

    o_count <= std_logic_vector(to_unsigned(cnt_reg,N));
    
end architecture rtl;