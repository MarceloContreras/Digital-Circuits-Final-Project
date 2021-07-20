library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bitregister is
    generic(length: INTEGER:= 8);

    PORT(D: in STD_LOGIC_VECTOR(length-1 downto 0);
         rst,clk: in std_logic;
         Q: out STD_LOGIC_VECTOR(length-1 downto 0)
    );
 
end bitregister;

architecture Behavioral of bitregister is

begin
    process(rst,clk)
    begin
        if rst='0' then
            Q<="00000000";
        elsif rising_edge(clk) then
            Q<=D;
        end if;
    end process;

end Behavioral;
