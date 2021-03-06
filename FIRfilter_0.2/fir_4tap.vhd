library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity fir_4tap is
GENERIC(A : INTEGER := 4);
port(   clk : in std_logic; --clock signal
        Xin : in std_logic_vector(A-1 downto 0); --input signal
        Yout : out std_logic_vector(A*2-1 downto 0)  --filter output
        );
end fir_4tap;

architecture Behavioral of fir_4tap is

component flipflopD is
   GENERIC(LENGTH: INTEGER:= 8);
   port(
      Q : out std_logic_vector(LENGTH-1 downto 0);      
      clk :in std_logic;      
      D :in  std_logic_vector(LENGTH-1 downto 0)      
   );
end component; 
   
component Wallace4 is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
           prod : out STD_LOGIC_VECTOR (7 downto 0));
end component;   

component Wallace8 is
    Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
           prod : out STD_LOGIC_VECTOR (15 downto 0));
end component;    

component booth_multiplier is
    GENERIC (x : INTEGER := 4;
		 y : INTEGER := 4);
	
	PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
end component;


signal H0,H1,H2,H3 : std_logic_vector(A-1 downto 0) := (others => '0');
signal MCM0,MCM1,MCM2,MCM3,add_out1,add_out2,add_out3 : std_logic_vector(A*2-1 downto 0) := (others => '0');
signal Q1,Q2,Q3 : std_logic_vector(A*2-1 downto 0) := (others => '0');
signal sum1,sum2,sum3: unsigned(A*2-1 downto 0):= (others => '0');


begin

-- Coeficientes de IR para 4 bits
H0 <= "0010";
H1 <= "0011";
H2 <= "0010";
H3 <= "0000";

-- Coeficientes de IR para 8 bits
--H0 <= X"1C";
--H1 <= X"38";
--H2 <= X"1C";
--H3 <= X"00";

--Coeficientes de IR para 16 bits
--H0 <= X"1C6F";
--H1 <= X"37E6";
--H2 <= X"1C6F";
--H3 <= X"0000";

-- Taps
Mult3: Wallace4 port map(H3,Xin,MCM3);
Mult2: Wallace4  port map(H2,Xin,MCM2);
Mult1: Wallace4  port map(H1,Xin,MCM1);
Mult0: Wallace4  port map(H0,Xin,MCM0);


--Sumas
sum1<=unsigned(Q1)+unsigned(MCM2);
sum2<=unsigned(Q2)+unsigned(MCM1);
sum3<=unsigned(Q3)+unsigned(MCM0);

add_out1<=std_logic_vector(sum1);
add_out2<=std_logic_vector(sum2);
add_out3<=std_logic_vector(sum3);


-- Registros con FlipFlopD
reg1 : flipflopD port map(Q1,Clk,MCM3);
reg2 : flipflopD port map(Q2,Clk,add_out1);
reg3 : flipflopD port map(Q3,Clk,add_out2);


sync:process(clk)
begin
    if(rising_edge(clk)) then
        Yout <= add_out3;
    end if;
end process;
   
end Behavioral;



