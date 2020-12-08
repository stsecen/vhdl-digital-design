library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bram is
    generic(
        M : integer := 8;
        N : integer := 32
    );
    port(
        clk,rst  : in  std_logic;
        w_en     : in  std_logic;
        i_addr   : in  std_logic_vector(M - 1 downto 0);
        i_data   : in  std_logic_vector(N - 1 downto 0);
        o_data   : out std_logic_vector(N - 1 downto 0)
    );
end entity bram;

architecture rtl of bram is

    type ram_type is array(0 to 2**M - 1) of std_logic_vector(N - 1 downto 0);
    signal BRAM : ram_type := (others => (others => '0'));

begin

    block_ram: process(clk, rst)
    begin
        if rst = '1' then
            BRAM <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if w_en = '1' then 
                BRAM(to_integer(unsigned(i_addr))) <= i_data;
            end if;
            o_data <= BRAM(to_integer(unsigned(i_data)));
        end if;
    end process block_ram;
   
end rtl;