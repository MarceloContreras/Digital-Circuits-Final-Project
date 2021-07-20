library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Compressor52 is
    Port ( x1,x2,x3,x4,x5,cin1,cin2 : in STD_LOGIC;
           sum,cout1,cout2,carry : out STD_LOGIC);
end Compressor52;

architecture Behavioral of Compressor52 is

begin

sum<=x1 xor x2 xor x3 xor x4 xor x5;
cout1<= ((x1 xor x2) and x3) or (not(x1 xor x2) and x1);
cout2<= ((x1 xor x2 xor x3 xor x4) and cin1) or (not(x1 xor x2 xor x3 xor x4) and (x1 xor x2 xor x3));
carry<= ((x1 xor x2 xor x3 xor x4 xor cin1) and x5) or (((x1 xor x2 xor x3 xor x4 xor cin1) or x5)and cin2);

end Behavioral;
