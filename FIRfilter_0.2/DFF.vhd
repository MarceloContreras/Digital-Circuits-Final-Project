library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity flipflopD is
 GENERIC(LENGTH: INTEGER:= 4);
   port(
      Q : out std_logic_vector(LENGTH-1 downto 0);      
      clk :in std_logic;    
      D :in  std_logic_vector(LENGTH-1 downto 0)      
   );
end flipflopD;

architecture Behavioral of flipflopD is

signal qreg : std_logic_vector(LENGTH-1 downto 0) := (others => '0');

begin

Q <= qreg;

    sincronizacion:process(Clk)
    begin
      if (rising_edge(clk)) then
        qreg <= D;
      end if;      
    end process;

end Behavioral;
