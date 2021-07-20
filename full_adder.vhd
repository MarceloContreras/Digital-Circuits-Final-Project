library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( a,b,c : in STD_LOGIC;
           sum,carry : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

begin

sum <= (a xor b xor c);
carry <= (a and b) xor (c and (a xor b));

end Behavioral;
