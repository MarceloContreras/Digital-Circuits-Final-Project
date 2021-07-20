library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Wallace16 is
    GENERIC (DW: INTEGER := 16);
    Port ( A,B : in STD_LOGIC_VECTOR (DW-1 downto 0);
           prod : out STD_LOGIC_VECTOR (2*DW-1 downto 0));
end Wallace16;

architecture Behavioral of Wallace16 is

component half_adder is 
    Port ( a,b : in STD_LOGIC;
           sum,carry : out STD_LOGIC);
end component;

component full_adder is 
        Port ( a,b,c : in STD_LOGIC;
           sum,carry : out STD_LOGIC);
end component;

signal p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15: std_logic_vector(DW-1 downto 0);
signal s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15: std_logic_vector(DW+1 downto 0);
signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15: std_logic_vector(DW+1 downto 0);


begin

    Productoparciales:process(A,B)
    begin
        for i in 0 to DW-1 loop 
            p0(i) <= A(0) and B(i);
            p1(i) <= A(1) and B(i);
            p2(i) <= A(2) and B(i);
            p3(i) <= A(3) and B(i);
            p4(i) <= A(4) and B(i);
            p5(i) <= A(5) and B(i);
            p6(i) <= A(6) and B(i);
            p7(i) <= A(7) and B(i);
            p8(i) <= A(8) and B(i);
            p9(i) <= A(9) and B(i);
            p10(i) <= A(10) and B(i);
            p11(i) <= A(11) and B(i);
            p12(i) <= A(12) and B(i);
            p13(i) <= A(13) and B(i);
            p14(i) <= A(14) and B(i);
            p15(i) <= A(15) and B(i);
        end loop;  
    end process;
    
    prod(0) <= p0(0);
    prod(1) <= s0(1);
    prod(2) <= s2(2);
    prod(3) <= s3(7);
    prod(4) <= s4(9);
    prod(5) <= s5(0);
    prod(6) <= s5(1);
    prod(7) <= s6(0);
    prod(8) <= s6(1);
    prod(9) <= s6(2);
    prod(10) <= s6(3);
    prod(11) <= s6(4);
    prod(12) <= s6(5);
    prod(13) <= s6(6);
    prod(14) <= s6(7);
    prod(15) <= s6(8) or c6(8);
  
-- Primera etapa
ha000: half_adder port map(p0(1), p1(0), s0(0), c0(0));
ha001: half_adder port map(p3(1), p4(0), s0(4), c0(4));
ha002: half_adder port map(p3(1), p4(0), s0(11), c0(11));
ha003: half_adder port map(p3(1), p4(0), s1(3), c1(3));
ha004: half_adder port map(p3(1), p4(0), s1(17), c1(17));
fa000: full_adder port map(p0(2), p1(1), p2(0), s0(1), c0(1));
fa001: full_adder port map(p0(3), p1(2), p2(1), s0(2), c0(2));
fa002: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa003: full_adder port map(p0(5), p1(4), p2(3), s0(5), c0(5));
fa004: full_adder port map(p0(4), p1(3), p2(2), s0(6), c0(6));
fa005: full_adder port map(p0(6), p1(5), p2(4), s0(7), c0(7));
fa006: full_adder port map(p0(4), p1(3), p2(2), s0(8), c0(8));
fa007: full_adder port map(p0(7), p1(6), p2(5), s0(9), c0(9));
fa008: full_adder port map(p0(4), p1(3), p2(2), s0(10), c0(10));
fa009: full_adder port map(p0(8), p1(7), p2(6), s0(12), c0(12));
fa010: full_adder port map(p0(4), p1(3), p2(2), s0(13), c0(13));
fa011: full_adder port map(p0(4), p1(3), p2(2), s0(14), c0(14));
fa012: full_adder port map(p0(9), p1(8), p2(7), s0(15), c0(15));
fa013: full_adder port map(p0(4), p1(3), p2(2), s0(16), c0(16));
fa014: full_adder port map(p0(4), p1(3), p2(2), s0(17), c0(17));
fa015: full_adder port map(p0(10), p1(9), p2(8), s1(0), c1(0));
fa016: full_adder port map(p0(4), p1(3), p2(2), s1(1), c1(1));
fa017: full_adder port map(p0(4), p1(3), p2(2), s1(2), c1(2));
fa018: full_adder port map(p0(11), p1(10), p2(9), s1(4), c1(4));
fa019: full_adder port map(p0(4), p1(3), p2(2), s1(5), c1(5));
fa020: full_adder port map(p0(4), p1(3), p2(2), s1(6), c1(6));
fa021: full_adder port map(p0(4), p1(3), p2(2), s1(7), c1(7));
fa022: full_adder port map(p0(12), p1(11), p2(10), s1(8), c1(8));
fa023: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa024: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa025: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa026: full_adder port map(p0(13), p1(12), p2(11), s0(3), c0(3));
fa027: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa028: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa029: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa030: full_adder port map(p0(14), p1(13), p2(12), s0(3), c0(3));
fa031: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa032: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa033: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa034: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa035: full_adder port map(p0(15), p1(14), p2(13), s0(3), c0(3));
fa036: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa037: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa038: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
fa039: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));

-- Segunda etapa
ha10: half_adder port map(s0(2),c0(1),s2(2),c2(2));
fa10: full_adder port map(p0(3),c0(2),s0(3),s2(3),c2(3));
fa11: full_adder port map(s0(4),s0(5),c0(3),s2(4),c2(4));
fa12: full_adder port map(s0(6),s0(7),c0(4),s2(5),c2(5));
fa13: full_adder port map(s0(8),s0(9),p0(6),s2(6),c2(6));
ha11: half_adder port map(c0(6),c0(7),s2(7),c2(7));
fa14: full_adder port map(s1(0),s1(1),s1(2),s2(8),c2(8));
ha12: half_adder port map(c0(8),c0(9),s2(9),c2(9));
fa15: full_adder port map(s1(3),s1(4),p1(7),s3(0),c3(0));
fa16: full_adder port map(c1(0),c1(1),c1(2),s3(1),c3(1));
fa17: full_adder port map(s1(5),s1(6),c1(3),s3(2),c3(2));
fa18: full_adder port map(s1(7),s1(8),c1(5),s3(3),c3(3));
fa19: full_adder port map(s1(9),c1(7),c1(8),s3(4),c3(4));
ha13: half_adder port map(s2(0),c1(9),s3(5),c3(5));
ha14: half_adder port map(s2(1),c2(0),s3(6),c3(6));

-- Tercera etapa
ha40: half_adder port map(s2(3),c2(2),s3(7),c3(7));
ha41: half_adder port map(c2(3),s2(4),s3(8),c3(8));
fa40: full_adder port map(c2(4),s2(5),c0(5),s3(9),c3(9));
fa41: full_adder port map(c2(5),s2(6),s2(7),s4(0),c4(0));
fa42: full_adder port map(c2(6),c2(7),s2(8),s4(1),c4(1));
fa43: full_adder port map(c2(8),c2(9),s3(0),s4(2),c4(2));
fa44: full_adder port map(c3(0),c3(1),s3(2),s4(3),c4(3));
fa45: full_adder port map(c3(2),c1(6),s3(3),s4(4),c4(4));
fa46: full_adder port map(c3(3),p4(7),s3(4),s4(5),c4(5));
ha42: half_adder port map(s3(5),c3(4),s4(6),c4(6));
ha43: half_adder port map(c3(5),s3(6),s4(7),c4(7));
fa47: full_adder port map(p7(7),c2(1),c3(6),s4(8),c4(8));

-- Cuarta etapa
ha50: half_adder port map(c3(7),s3(8),s4(9),c4(9));
fa50: full_adder port map(s3(9),c3(8),c4(9),s5(0),c5(0));
fa51: full_adder port map(s4(0),c3(9),c5(0),s5(1),c5(1));
fa52: full_adder port map(c4(0),s4(1),s2(9),s5(2),c5(2));
fa53: full_adder port map(c4(1),s3(1),s4(2),s5(3),c5(3));
fa54: full_adder port map(c1(4),c4(2),s4(3),s5(4),c5(4));
fa55: full_adder port map(s4(4),c4(3),c5(4),s5(5),c5(5));
fa56: full_adder port map(c4(4),s4(5),c5(5),s5(6),c5(6));
fa57: full_adder port map(s4(6),c4(5),c5(6),s5(7),c5(7));
fa58: full_adder port map(c4(6),s4(7),c5(7),s5(8),c5(8));
fa59: full_adder port map(s4(8),c4(7),c5(8),s5(9),c5(9));

-- Quinta etapa
ha70: half_adder port map(c5(1),s5(2),s6(0),c6(0));
fa70: full_adder port map(c5(2),s5(3),c6(0),s6(1),c6(1));
fa71: full_adder port map(c5(3),s5(4),c6(1),s6(2),c6(2));
ha71: half_adder port map(s5(5),c6(2),s6(3),c6(3));
ha72: half_adder port map(s5(6),c6(3),s6(4),c6(4));
ha73: half_adder port map(s5(7),c6(4),s6(5),c6(5));
ha74: half_adder port map(s5(8),c6(5),s6(6),c6(6));
ha75: half_adder port map(s5(9),c6(6),s6(7),c6(7));
fa81: full_adder port map(c4(8),c5(9),c6(7),s6(8),c6(8));

end Behavioral;
