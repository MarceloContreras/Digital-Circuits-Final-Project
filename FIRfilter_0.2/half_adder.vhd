library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port ( a,b : in STD_LOGIC;
           sum,carry : out STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is

begin

sum<=a xor b;
carry<= a and b;

end Behavioral;
