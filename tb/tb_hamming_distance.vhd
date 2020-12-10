library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_hamming_distance is
end tb_hamming_distance;

architecture bhv of tb_hamming_distance is

    constant N : integer := 16;
    signal a, b : std_logic_vector(N-1 downto 0) := (others => '0');
    signal d    : std_logic_vector(9 downto 0) := (others => '0');

begin

    h0 : entity work.hamming_distance(rtl)
      generic map (N => N)
      port map (i_data0 => a, i_data1 => b, o_dist => d);

    -- stimulus
    process
    begin
        wait for 10 ns;
        a <= x"AAAA";
        b <= x"0000";
        wait for 10 ns;
        a <= x"FFFF";
        b <= x"FFFE";
        wait for 10 ns;
        a <= x"1100";
        b <= x"0011";
        wait for 10 ns;
        a <= x"0000";
        b <= x"FFFF";
        wait for 10 ns;
        wait;
    end process;
end bhv;