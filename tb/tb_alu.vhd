library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity tb_alu;

architecture rtl of tb_alu is
    constant N: integer := 32;
    constant AADD: std_logic_vector(2 downto 0) := "000";
    constant ASUB: std_logic_vector(2 downto 0) := "001";
    constant AAND: std_logic_vector(2 downto 0) := "010";
    constant AORR: std_logic_vector(2 downto 0) := "011";
    constant ANOR: std_logic_vector(2 downto 0) := "100";
    constant AXOR: std_logic_vector(2 downto 0) := "101";
    constant ALES: std_logic_vector(2 downto 0) := "110";
    constant ANOT: std_logic_vector(2 downto 0) := "111";
    signal s_data0  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s_data1  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s_opcode : std_logic_vector(2 downto 0) := (others => '0');
    signal s_result : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s_flags  : std_logic_vector(3 downto 0) := (others => '0');
begin

    h0 : entity work.alu(rtl)
    generic map (N => N)
    port map (i_data0 => s_data0, i_data1 => s_data1, i_opcode => s_opcode, o_result => s_result, o_flags => s_flags);

    
    process
    begin
        wait for 10 ns;
        s_opcode <= AADD;
        s_data0 <= x"AAAA";
        s_data1 <= x"0000";
        wait for 10 ns;
        s_data0 <= x"FFFF";
        s_data1 <= x"FFFE";
        wait for 10 ns;
        s_data0 <= x"1100";
        s_data1 <= x"0011";
        wait for 10 ns;
        s_data0 <= x"0000";
        s_data1 <= x"FFFF";
        wait for 10 ns;
        s_opcode <= ASUB;
        s_data0 <= x"AAAA";
        s_data1 <= x"0000";
        wait for 10 ns;
        s_data0 <= x"FFFF";
        s_data1 <= x"FFFE";
        wait for 10 ns;
        s_data0 <= x"1100";
        s_data1 <= x"0011";
        wait for 10 ns;
        s_data0 <= x"0000";
        s_data1 <= x"FFFF";
        wait for 10 ns;
        s_opcode <= ALES;
        s_data0 <= x"AAAA";
        s_data1 <= x"0000";
        wait for 10 ns;
        s_data0 <= x"FFFF";
        s_data1 <= x"FFFE";
        wait for 10 ns;
        s_data0 <= x"1100";
        s_data1 <= x"0011";
        wait for 10 ns;
        s_data0 <= x"0000";
        s_data1 <= x"FFFF";
        wait for 10 ns;
        s_opcode <= ANOT;
        s_data0 <= x"AAAA";
        s_data1 <= x"0000";
        wait for 10 ns;
        s_data0 <= x"FFFF";
        s_data1 <= x"FFFE";
        wait for 10 ns;
        s_data0 <= x"1100";
        s_data1 <= x"0011";
        wait for 10 ns;
        s_data0 <= x"0000";
        s_data1 <= x"FFFF";
        wait for 10 ns;
        wait;
end process;
    
end architecture rtl;