library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rgb2yuv is
port(
    i_rgb : in  std_logic_vector(23 downto 0);
    o_yuv : out std_logic_vector(23 downto 0)
);
end rgb2yuv;


architecture rtl of rgb2yuv is
    
begin
    
    -- y =  0.299 R + 0.587 G + 0.114 B
    -- u = -0.147 R - 0.289 G + 0.436 B
    -- v =  0.615 R - 0.515 G - 0.100 B
    
    convert: process(i_rgb)

        variable r,g,b : signed(8 downto 0);  --> extra 1 bit for signed math operation to take guarantee the positive 
        variable y,u,v : signed(20 downto 0); --> maximum decimal number in formula is 615. it will be represent with 10 bit. 
                                              --> the max mult result will be 20 bit and MSB gurantee the signed bits always 0.
    begin
        r := signed('0' & i_rgb(23 downto 16));
        g := signed('0' & i_rgb(15 downto  8));
        b := signed('0' & i_rgb( 7 downto  0));
    
        y := (to_signed(299, 12)*r + to_signed(587,12)*g + to_signed(114, 12)*b)/1000;
        u := (to_signed(-147, 12)*r - to_signed(289,12)*g + to_signed(436, 12)*b)/1000;
        v := (to_signed(615, 12)*r - to_signed(515,12)*g - to_signed(100, 12)*b)/1000;

        o_yuv <= std_logic_vector(y(7 downto 0) & u(7 downto 0) & v(7 downto 0));

    end process convert;

end architecture rtl;
