
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wallace_tree4 is
	port ( 
			i_data0   : in std_logic_vector(3 downto 0);
			i_data1   : in std_logic_vector(3 downto 0);
			o_result  : out std_logic_vector(7 downto 0)
		  );
end wallace_tree4;

architecture rtl of wallace_tree4 is

    component half_adder is
        port(
            a,b: in std_logic;
            s,c: out std_logic
        );
    end component;

    component full_adder is
        port (
            a,b,ci: in std_logic;
            s,co: out std_logic     
        );
    end component;

    component carry_lookahead_adder is
        generic(N: integer := 64);
        port (
            --> inputs 
            i_dataA,i_dataB : in std_logic_vector(N-1 downto 0);
            i_carry : in std_logic;
            --> outputs 
            o_sum : out std_logic_vector(N-1 downto 0);
            o_carry : out std_logic
        );
    end component;
    
--> Product of Partials
signal p0	: std_logic_vector(3 downto 0);
signal p1	: std_logic_vector(3 downto 0);
signal p2	: std_logic_vector(3 downto 0);
signal p3	: std_logic_vector(3 downto 0);

--> Internal Signals:
signal s11,s12,s13,s14,s15,s21,s22,s23,s24,s25  : std_logic;
signal c11,c12,c13,c14,c15,c21,c22,c23,c24,c25 	: std_logic;

--> Final Line:
signal s_adder_line0 : std_logic_vector(7 downto 0);
signal s_adder_line1 : std_logic_vector(7 downto 0);

constant N: integer := 8;

begin

--> Product of Partials Generation:
process(i_data0, i_data1)
begin
	for jj in 0 to 3 loop
		p0(jj) <= i_data0(jj) and i_data1(0);
		p1(jj) <= i_data0(jj) and i_data1(1);
		p2(jj) <= i_data0(jj) and i_data1(2);
		p3(jj) <= i_data0(jj) and i_data1(3);
	end loop;
end process;

--> First Stage:
ha1: half_adder port map (a => p0(1), b => p1(0), s => s11, c => c11);
ha2: half_adder port map (a => p2(3), b => p3(2), s => s15, c => c15);
fa1: full_adder port map (a => p0(2), b => p1(1), ci => p2(0), s => s12, co => c12);
fa2: full_adder port map (a => p0(3), b => p1(2), ci => p2(1), s => s13, co => c13);
fa3: full_adder port map (a => p1(3), b => p2(2), ci => p3(1), s => s14, co => c14);

--> Second Stage
ha3: half_adder port map (a => s12,   b => c11, s => s21, c => c21);
ha4: half_adder port map (a => s14,   b => c13, s => s23, c => c23);
ha5: half_adder port map (a => s15,   b => c14, s => s24, c => c24);
ha6: half_adder port map (a => p3(3), b => c15, s => s25, c => c25);
fa4: full_adder port map (a => s13,   b => p3(0), ci => c12, s => s22, co => c22);

--> Assign Final Lines:
s_adder_line0(0) <= p0(0);
s_adder_line0(1) <= s11;
s_adder_line0(2) <= s21;
s_adder_line0(3) <= s22;
s_adder_line0(4) <= s23;
s_adder_line0(5) <= s24;
s_adder_line0(6) <= s25;
s_adder_line0(7) <= c25;

s_adder_line1(0) <= '0';
s_adder_line1(1) <= '0';
s_adder_line1(2) <= '0';
s_adder_line1(3) <= c21;
s_adder_line1(4) <= c22;
s_adder_line1(5) <= c23;
s_adder_line1(6) <= c24;
s_adder_line1(7) <= '0';

-- Final Adition with CLA:
cla: carry_lookahead_adder
            generic map( N=> N)
            port map(
                i_dataA => s_adder_line0,
                i_dataB => s_adder_line1,
                i_carry => '0',
                o_sum   => o_result,
                o_carry => open
            );

end architecture;
