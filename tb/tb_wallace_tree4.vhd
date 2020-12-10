library ieee;
use ieee.std_logic_1164.ALL;

entity tb_wallace_tree4 is
end tb_wallace_tree4;

architecture bhv of tb_wallace_tree4 is
component wallace_tree4 is
	port ( 
			i_data0   : in std_logic_vector(3 downto 0);
			i_data1   : in std_logic_vector(3 downto 0);
			o_result : out std_logic_vector(7 downto 0)
		  );
end component;

signal A_sig        :  std_logic_vector(3 downto 0) := (others => '0');
signal B_sig        :  std_logic_vector(3 downto 0) := (others => '0');
signal o_result_sig   :  std_logic_vector(7 downto 0) := (others => '0');

begin

 uut : wallace_tree4 port map
    (
        i_data0 => A_sig,
        i_data1 => B_sig,
		o_result => o_result_sig 
    );    
    
    -- Test Cases:
    stim_proc : process
    begin
    A_sig <= "0110";
    B_sig <= "0100";
    wait for 20ns;
    
    A_sig <= "1010";
    B_sig <= "1110";
    wait for 20ns;
    
    A_sig <= "1000";
    B_sig <= "1111";
    wait for 20ns;
    
    A_sig <= "0000";
    B_sig <= "1111";
    wait for 20ns;
    
    A_sig <= "1111";
    B_sig <= "1111";
    wait for 20ns;
    
    wait;
    
    end process;

end bhv;
