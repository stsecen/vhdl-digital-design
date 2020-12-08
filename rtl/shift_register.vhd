library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    generic(
        N : integer := 32
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_ctrl : in std_logic;
        i_data : in std_logic;
        o_data : out std_logic
    );
end entity shift_register;


architecture rtl of shift_register is
    
    signal r_data,r_reg : std_logic_vector(N-1 downto 0) := (others => '0');
    
begin
    
    shifting: process(clk)
    begin
        if rst = '1' then
            r_data <= (others => '0');
        elsif rising_edge(clk) then
            r_reg <= r_data;
        end if; 
    end process shifting;

    controlling: process(i_ctrl,r_reg)
    begin
        case i_ctrl is
            when '0' =>                 --> shift right
                r_data(N-1) <= i_data;
                r_data(N-2 downto 0) <= r_reg(N-1 downto 1);
            when '1' =>                --> shift left
                r_data(N-1 downto 1) <= r_reg(N-2 downto 0);
                r_data(0) <= i_data; 
            when others =>
                r_data <= r_reg;        --> nop
        end case;
    end process controlling;
    
    o_data <= r_reg(N-1);
    
end architecture rtl;