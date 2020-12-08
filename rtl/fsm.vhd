library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
    port (
        clk, rst : in std_logic;
        i_data0, i_data1: in std_logic;
        o_mealy, o_moore : out std_logic
    );
end entity fsm;

architecture rtl of fsm is
    type states is (s0,s1,s2);
    signal state_reg, state_next : states := s0;
begin

    state_register: process(clk, rst)
    begin
        if rst = '1' then
            state_reg <= s0; --> initial state
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process state_register;
    
    next_state_logic: process(i_data0,i_data1,state_reg)
    begin
        case state_reg is
            when s0 =>
                if i_data0 = '1' then 
                    if i_data1 = '0' then 
                        state_next <= s1;
                    else 
                        state_next <= s2;
                    end if;
                else 
                    state_next <= s0;
                end if;
            when s1 =>
                if i_data0 = '0' then 
                    if i_data1 = '1' then 
                        state_next <= s2;
                    else 
                        state_next <= s0;
                    end if;
                else 
                    state_next <= s0;
                end if;
            when s2 =>
                state_next <= s0;
            when others =>
                state_next <= s0;
        end case;
    end process next_state_logic;

    -- output logic (moore)
    process(state_reg) is
    begin
        case state_reg is
        when s0 =>
            o_moore <= '0';
        when s1 =>
            o_moore <= '1';
        when s2 =>
            o_moore <= '0';
        end case;
    end process;


    -- output logic (mealy)
    process(state_reg, i_data0, i_data1) is
    begin
        case state_reg is
        when s0 =>
            if i_data0 = '1' and i_data1 = '0' then
                o_mealy <= '1';
            else
                o_mealy <= '0';
            end if;
        when s1 =>
            o_mealy <= '0';
        when s2 =>
            o_mealy <= '0';
        end case;
    end process;
    
end architecture rtl;