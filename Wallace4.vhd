
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Wallace4 is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
           prod : out STD_LOGIC_VECTOR (7 downto 0));
end Wallace4;

architecture Behavioral of Wallace4 is

component half_adder is 
    Port ( a,b : in STD_LOGIC;
           sum,carry : out STD_LOGIC);
end component;

component full_adder is 
        Port ( a,b,c : in STD_LOGIC;
           sum,carry : out STD_LOGIC);
end component;


signal p0,p1,p2,p3: std_logic_vector(6 downto 0 ); -- Producto parciales Stage 1 
signal s11,s12,s13,s14,s15,s22,s23,s24,s25,s26,s32,s33,s34,s35,s36,s37: std_logic; -- Sumas
signal c11,c12,c13,c14,c15,c22,c23,c24,c25,c26,c32,c33,c34,c35,c36,c37: std_logic; -- Carries 


begin

    Productoparciales:process(A,B)
    begin 
    for i in 0 to 3 loop 
        p0(i) <= A(i) and B(0);
        p1(i) <= A(i) and B(1);
        p2(i) <= A(i) and B(2);
        p3(i) <= A(i) and B(3);
    end loop;   
    end process;
    
    prod(0) <= p0(0);
    prod(1) <= s11;
    prod(2) <= s22;
    prod(3) <= s32;
    prod(4) <= s34;
    prod(5) <= s35;
    prod(6) <= s36;
    prod(7) <= s37;
    
    -- Primer stage
    hal1: half_adder port map(p0(1),p1(0),s11,c11);
    fa12: full_adder port map(p0(2),p1(1),p2(0),s12,c12);
    fa13: full_adder port map(p0(3),p1(2),p2(1),s13,c13);
    fa14: full_adder port map(p1(3),p2(2),p3(1),s14,c14);
    ha15: half_adder port map(p2(3),p3(2),s15,c15);
    
    -- Segundo stage
    ha22: half_adder port map(c11,s12,s22,c22);
    fa23: full_adder port map(p3(0),c12,s13,s23,c23);
    fa24: full_adder port map(c13,c32,s14,s24,c24);
    fa25: full_adder port map(c14,c24,s15,s25,c25);
    fa26: full_adder port map(c15,c25,p3(3),s26,c26);
    
    -- Tercer stage
    ha32: half_adder port map(c22,s23,s32,c32);
    ha34: half_adder port map(c23,s24,s34,c34);
    ha35: half_adder port map(c34,s25,s35,c35);
    ha36: half_adder port map(c35,s26,s36,c36);
    ha37: half_adder port map(c36,c26,s37,c37);
    
end Behavioral;
