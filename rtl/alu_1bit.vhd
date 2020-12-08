--> 1-bit alu circuit (with process)
--> functions implemented
-->   opcode  function
-->   000     x + y
-->   001     x - y
-->   010     x and y
-->   011     x or y
-->   100     x nor y
-->   101     x xor y
-->   110     x < y
-->   111     not x
library ieee;
use ieee.std_logic_1164.all;

entity alu_1bit is
    port (
        i_data0, i_data1    : in std_logic;
        i_carry             : in std_logic;
        i_opcode            : in std_logic_vector(2 downto 0);
        o_result            : out std_logic;
        o_carry             : out std_logic
    );
end entity alu_1bit;

architecture rtl of alu_1bit is

    constant AADD: std_logic_vector(2 downto 0) := "000";
    constant ASUB: std_logic_vector(2 downto 0) := "001";
    constant AAND: std_logic_vector(2 downto 0) := "010";
    constant AORR: std_logic_vector(2 downto 0) := "011";
    constant ANOR: std_logic_vector(2 downto 0) := "100";
    constant AXOR: std_logic_vector(2 downto 0) := "101";
    constant ALES: std_logic_vector(2 downto 0) := "110";
    constant ANOT: std_logic_vector(2 downto 0) := "111";

begin
    
    alu: process(i_data0,i_data1,i_carry,i_opcode)
    begin
        o_result <= '0';
        o_carry  <= '0';

        case i_opcode is

            when AADD =>
                o_result <= i_data0 xor i_data1 xor i_carry;
                o_carry  <= (i_data0 and i_data1)  or (i_data0 and i_carry) or (i_data1 and i_carry);
            when ASUB =>
                o_result <= i_data0 xor i_data1 xor i_carry;
                o_carry  <= (not(i_data0) and i_data1)  or ((not(i_data0 xor i_carry)) and i_carry);            
            when AORR =>
                o_result <= i_data0 and i_data1;
            when ANOR =>
                o_result <= i_data0 nor i_data1;
            when AXOR =>
                o_result <= i_data0 xor i_data0;
            when ALES => 
                if i_data0 = '0' and i_data1 = '1' then
                    o_result <= '1';
                else
                    o_result <= '0';
                end if;
            when ANOT =>
                o_result <= not(i_data0);  
            when others =>
                o_result <= '0';
                o_carry <= '0';

        end case;
    end process alu;
    
    
end architecture rtl;