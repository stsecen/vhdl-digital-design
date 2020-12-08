library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lfsr is
    generic(N: integer := 3);
    port (
        clk,rst : in std_logic;
        o_data : out std_logic_vector(N downto 0)
    );
end entity lfsr;

architecture rtl of lfsr is
    signal r_regs, r_next_regs : std_logic_vector(N downto 0);
    signal w_fb : std_logic;
begin
    reg: process(clk, rst)
    begin
        if rst = '1' then
            r_regs(0) <= '1'; 
            r_regs(N downto 1) <= (others => '0');
        elsif rising_edge(clk) then
            r_regs <= r_next_regs;
        end if;
    end process reg;

    o_data <= r_regs;
    r_next_regs <= w_fb & r_regs(N downto 1);

    gen2: if N = 2 generate
        w_fb <= r_regs(N) xor r_regs(1) xor r_regs(0);
    end generate gen2;
    gen3: if N = 3 generate
        w_fb <= r_regs(N) xor r_regs(2) xor r_regs(0);
    end generate gen3;
    gen4: if N = 4 generate
        w_fb <= r_regs(N) xor r_regs(3) xor r_regs(0);
    end generate gen4;
    gen5: if N = 5 generate
        w_fb <= r_regs(N) xor r_regs(3) xor r_regs(0);
    end generate gen5;
    gen6: if N = 6 generate
        w_fb <= r_regs(N) xor r_regs(5) xor r_regs(0);
    end generate gen6;
    gen7: if N = 7 generate
        w_fb <= r_regs(N) xor r_regs(6) xor r_regs(0);
    end generate gen7;
    gen8: if N = 9 generate
        w_fb <= r_regs(N) xor r_regs(6) xor r_regs(5) xor r_regs(4) xor r_regs(0);
    end generate gen8;
    gen9: if N = 9 generate
        w_fb <= r_regs(N) xor r_regs(5) xor r_regs(0);
    end generate gen9;
    gen10: if N = 10 generate
        w_fb <= r_regs(N) xor r_regs(7) xor r_regs(0);
    end generate gen10;
    
end architecture rtl;

