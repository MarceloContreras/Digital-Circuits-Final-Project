library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity fir_4tap is
port(   Clk : in std_logic; --clock signal
        Xin : in std_logic_vector(7 downto 0); --input signal
        Yout : out std_logic_vector(15 downto 0)  --filter output
        );
end fir_4tap;

architecture Behavioral of fir_4tap is

component DFF is
   port(
      Q : out std_logic_vector(15 downto 0);      --output connected to the adder
      Clk :in std_logic;      -- Clock input
      D :in  std_logic_vector(15 downto 0)      -- Data input from the MCM block.
   );
end component; 
   
component Wallace8 is
    Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
           prod : out STD_LOGIC_VECTOR (15 downto 0));
end component;    
   

signal H0,H1,H2,H3 : std_logic_vector(7 downto 0) := (others => '0');
signal MCM0,MCM1,MCM2,MCM3,add_out1,add_out2,add_out3 : std_logic_vector(15 downto 0) := (others => '0');
signal Q1,Q2,Q3 : std_logic_vector(15 downto 0) := (others => '0');
signal sum1,sum2,sum3: unsigned(15 downto 0):= (others => '0');


begin

--filter coefficient initializations.
--H = [-2 -1 3 4].
H0 <= X"01";
H1 <= X"02";
H2 <= X"03";
H3 <= X"02";

--Multiple constant multiplications.
--MCM3 <= H3*Xi;
Mult3: Wallace8 port map(H3,Xin,MCM3);
Mult2: Wallace8 port map(H2,Xin,MCM2);
Mult1: Wallace8 port map(H1,Xin,MCM1);
Mult0: Wallace8 port map(H0,Xin,MCM0);

--adders

sum1<=unsigned(Q1)+unsigned(MCM2);
sum2<=unsigned(Q2)+unsigned(MCM1);
sum3<=unsigned(Q3)+unsigned(MCM0);

add_out1<=std_logic_vector(sum1);
add_out2<=std_logic_vector(sum2);
add_out3<=std_logic_vector(sum3);


--flipflops(for introducing a delay).
dff1 : DFF port map(Q1,Clk,MCM3);
dff2 : DFF port map(Q2,Clk,add_out1);
dff3 : DFF port map(Q3,Clk,add_out2);

--an output produced at every positive edge of clock cycle.
process(Clk)
begin
    if(rising_edge(Clk)) then
        Yout <= add_out3;
    end if;
end process;
   
end Behavioral;