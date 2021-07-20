library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Compressor42 is
    Port ( x1,x2,x3,x4,cin : in STD_LOGIC;
           sum,Cout,carry : out STD_LOGIC);
end Compressor42;

architecture Behavioral of Compressor42 is

begin

sum<=x1 xor x2 xor x3 xor x4;
Cout<= ((x1 xor x2) and x3 )or (not(x1 xor x2) and x1);
carry<= ((x1 xor x2 xor x3 xor x4)and cin) or (not(x1 xor x2 xor x3 xor x4) and x4);

end Behavioral;
