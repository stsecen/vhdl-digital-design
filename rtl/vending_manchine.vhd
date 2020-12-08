library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vending_manchine is
    port (
        clk, rst : in std_logic;
        i_sel    : in std_logic_vector(1 downto 0);
        i_cash   : in std_logic_vector(2 downto 0);
        o_change : out std_logic_vector(2 downto 0);
        o_cmplt  : out std_logic;
        o_product : out std_logic_vector(1 downto 0)
    );
end entity vending_manchine;

architecture rtl of vending_manchine is
    type state_type is (
        idle,
        sel,
        cash_in, 
        give,
        change
    );
    signal state : state_type := idle;
    
    function std2money(signal a: in std_logic_vector(2 downto 0)) 
                            return natural is variable cash : natural;
    begin
        case a is
            when "000" =>
                cash := 5;
            when "001" =>
                cash := 10;
            when "010" =>
                cash := 25;
            when "011" =>
                cash := 50;
            when "100" =>
                cash := 100;
            when "101" =>
                cash := 500;
            when "110" =>
                cash := 1000;
            when "111" =>
                cash := 0;
            when others =>
                cash := 0;
            end case;    
        return cash;
    end std2money; -- function ends

    function money2std(signal a: in natural) 
                            return unsigned is variable changex : unsigned(2 downto 0);
    begin
        if a >= 1000 then
            changex := "110";
        elsif a <= 500 and a > 100 then
            changex := "101";
        elsif a <= 100 and a > 50 then
            changex := "100";
        elsif a <= 50 and a > 25 then
            changex := "011";
        elsif a <= 25 and a > 10  then
            changex := "010";
        elsif a <= 10 and a > 5 then
            changex := "001";
        elsif a = 5 then
            changex := "000";
        else 
            changex := "111";
        end if;
        return changex;
    end money2std; -- function ends

    function money2money(signal a: in natural) 
                            return natural is variable changed : natural range 0 to 2000;
    begin
        if a >= 10 then
            changed := a-1000;
        elsif a <= 5 and a > 1 then
            changed := a-500;
        elsif a <= 1 and a > 50 then
            changed := a-100;
        elsif a <= 50 and a > 25 then
            changed := a-50;
        elsif a <= 25 and a > 10  then
            changed := a-25;
        elsif a <= 10 and a > 5 then
            changed := a-10;
        elsif a = 5 then
            changed := a-5;
        else 
            changed := a;
        end if;
        return changed;
    end money2money; -- function ends
    
    
begin

    vending: process(clk, rst)

    variable v_desired_money : natural  range 0 to 2000 := 0;
    variable v_total_money : natural range 0 to 2000 := 0;
    variable v_reg_product : std_logic_vector(1 downto 0);
    variable v_change : natural range 0 to 2000 := 0;

    begin
        if rst = '1' then
            o_product <= "00";
            o_change <=  "111";
            o_cmplt <= '0';
            v_total_money := 0;
            v_reg_product := "00";
        elsif rising_edge(clk) then
            case state is

                when idle =>
                    o_product <= "00";
                    o_change <=  "111";
                    v_total_money := 0;
                    v_reg_product := "00";
                    o_cmplt <= '0';
                    
                    if i_sel /= "00" then 
                        state <= sel;
                    else 
                        state <= idle;
                    end if; 

                when sel =>
                    v_reg_product := i_sel;
                    if i_sel = "01" then 
                        v_desired_money := 150; --> the water price
                        state <= cash_in;
                    elsif i_sel = "10" then 
                        v_desired_money := 200;   --> the tea price
                        state <= cash_in;
                    elsif i_sel = "11" then 
                        v_desired_money := 250; --> the coffee price
                        state <= cash_in;
                    else 
                        v_desired_money := 0;
                        state <= idle;
                    end if;

                when cash_in =>
                    v_total_money := std2money(i_cash) + v_total_money;
                    if v_total_money >= v_desired_money then 
                        state <= give;
                    else 
                        state <= cash_in;
                    end if;

                when give =>
                    o_product <= v_reg_product; 
                    v_change := v_total_money - v_desired_money;
                    state <= change; 

                when change =>
                    if v_change /= 0 then 
                        o_change <= std_logic_vector(money2std(a=>v_change));
                        v_change := money2money(a=>v_change);
                        state <= change;
                    else 
                        state <= idle;
                        o_change <= "111";
                        o_cmplt <= '1';
                    end if;

                when others =>  
                    state <= idle;      

            end case;    
        end if;
    end process vending;
    
end architecture rtl;