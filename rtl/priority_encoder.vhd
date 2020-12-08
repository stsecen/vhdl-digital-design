library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_encoder is
    generic(M: integer := 5;
            N: integer := 32);
    port (
        i_data0 : in std_logic_vector(N-1 downto 0);
        o_valid : out std_logic;
        o_prior : out std_logic_vector(M-1 downto 0)
    );
end entity priority_encoder;

architecture rtl of priority_encoder is
begin
    
    prio: process(i_data0) is 
        variable v : std_logic_vector(M-1 downto 0) := (others => '0');
        variable valid : std_logic := '0';
        variable ori : std_logic := '0';
    begin 

        v := (others => '0');
        valid := '0';
        ori := '0';

        for jj in i_data0'high downto i_data0'low loop
            
            ori := ori or i_data0(jj);

            if i_data0(jj) = '1' and valid = '0' then
                v := std_logic_vector(to_unsigned(jj,M));
                valid := '1';
            end if;
        end loop;

        if ori = '0' then 
            valid := '0';
            v := (others => '0');
        else 
            valid := '1';
        end if; 

        o_valid <= valid;
        o_prior <= v;     

    end process prio;

end architecture rtl;
