-- tb_fsm_counter.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm_counter is
end tb_fsm_counter;

architecture rtl of tb_fsm_counter is

    signal clk  : std_logic := '0';
    constant M : integer := 31;
    constant N : integer := 5;
    signal o1   : std_logic_vector(N-1 downto 0) := (others => '0');
    constant wait_time : time := 10 ns;

begin

    fsm2a : entity work.fsm_counter(rtl)
    generic map(M=>M, N=>N)
    port map(clk=>clk, rst=>rst, o_count=>o1);


    process
    begin
          wait for wait_time;
          clk <= '1';
          wait for wait_time;
          clk <= '0';
    end process;

end rtl;
