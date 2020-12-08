library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    generic(N: integer := 32);
    port (

        i_data0     : in std_logic_vector(N-1 downto 0);
        i_data1     : in std_logic_vector(N-1 downto 0);
        i_opcode    : in std_logic_vector(2 downto 0);
        o_result    : out std_logic_vector(N-1 downto 0);
        o_flags     : out std_logic_vector(3 downto 0)        
  
    );
end entity alu;

architecture rtl of alu is

    signal w_data0, w_data1, w_result: unsigned(N downto 0) := (others => '0');
    signal w_sub : std_logic := '0';

    constant AADD: std_logic_vector(2 downto 0) := "000";
    constant ASUB: std_logic_vector(2 downto 0) := "001";
    constant AAND: std_logic_vector(2 downto 0) := "010";
    constant AORR: std_logic_vector(2 downto 0) := "011";
    constant ANOR: std_logic_vector(2 downto 0) := "100";
    constant AXOR: std_logic_vector(2 downto 0) := "101";
    constant ALES: std_logic_vector(2 downto 0) := "110";
    constant ANOT: std_logic_vector(2 downto 0) := "111";

begin

    w_data0 <= unsigned('0' & i_data0);
    w_data1 <= unsigned('0' & i_data1);

    op: process(w_data1,i_opcode,w_data0)
    begin
        
        w_sub <= '0';
        w_result <= (others => '0');

        case i_opcode is
            when AADD =>
                w_result <= w_data0 + w_data1;
            when ASUB =>
                w_result <= w_data0 - w_data1;
                w_sub <= '1';
            when AAND =>
                w_result(N-1 downto 0) <= w_data0(N-1 downto 0) and w_data1(N-1 downto 0);
            when AORR =>
                w_result(N-1 downto 0) <= w_data0(N-1 downto 0) or w_data1(N-1 downto 0);
            when ANOR =>
                w_result(N-1 downto 0) <= w_data0(N-1 downto 0) nor w_data1(N-1 downto 0);
            when AXOR =>
                w_result(N-1 downto 0) <= w_data0(N-1 downto 0) xor w_data1(N-1 downto 0);
            when ALES =>
                if w_data0 < w_data1 then
                    w_result(N-1 downto 0) <= (0=>'1', others=>'0');
                else 
                    w_result(N-1 downto 0) <= (others => '0');
                end if;
            when ANOT =>
                w_result(N-1 downto 0) <= not(w_data0(N-1 downto 0));
            when others =>
                w_result <= (others => '0');
        end case;
        
    end process op;
    
    o_result <= std_logic_vector(w_result(N-1 downto 0));

    --> flag(3)==Negative flag(2)==Zero flag(1)==Overflow flag(0)==Carry
    o_flags(3) <= w_result(N-1);
    o_flags(2) <= '1' when w_result(N-1 downto 0) = 0 else '0';
    o_flags(1) <= '1' when (w_data0(N-1) = '0' and w_data1(N-1) = '0' and w_result(N-1) = '1') or 
                          (w_data0(N-1) = '1' and w_data1(N-1) = '1' and w_result(N-1) = '0') or 
                          (w_data0(N-1) = '0' and w_data1(N-1) = '1' and w_result(N-1) = '1') or 
                          (w_data0(N-1) = '1' and w_data1(N-1) = '0' and w_result(N-1) = '0') else
                '0';

    o_flags(0) <= w_result(N) when w_sub= '0' else not(w_result(N));

    
end architecture rtl;