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
fa000: full_adder port map(p0(2), p1(1), p2(0), s0(1), c0(1));
fa001: full_adder port map(p0(3), p1(2), p2(1), s0(2), c0(2));
fa002: full_adder port map(p0(4), p1(3), p2(2), s0(3), c0(3));
ha001: half_adder port map(p3(1), p4(0), s0(4), c0(4));
fa003: full_adder port map(p0(5), p1(4), p2(3), s0(5), c0(5));
fa004: full_adder port map(p3(2), p4(1), p5(0), s0(6), c0(6));
fa005: full_adder port map(p0(6), p1(5), p2(4), s0(7), c0(7));
fa006: full_adder port map(p3(3), p4(2), p5(1), s0(8), c0(8));
fa007: full_adder port map(p0(7), p1(6), p2(5), s0(9), c0(9));
fa008: full_adder port map(p3(4), p4(3), p5(2), s0(10), c0(10));
ha002: half_adder port map(p6(1), p7(0), s0(11), c0(11));
fa009: full_adder port map(p0(8), p1(7), p2(6), s0(12), c0(12));
fa010: full_adder port map(p3(5), p4(4), p5(3), s0(13), c0(13));
fa011: full_adder port map(p6(2), p7(1), p8(0), s0(14), c0(14));
fa012: full_adder port map(p0(9), p1(8), p2(7), s0(15), c0(15));
fa013: full_adder port map(p3(6), p4(5), p5(4), s0(16), c0(16));
fa014: full_adder port map(p6(3), p7(2), p8(1), s0(17), c0(17));
fa015: full_adder port map(p0(10), p1(9), p2(8), s1(0), c1(0));

fa016: full_adder port map(p3(7), p4(6), p5(5), s1(1), c1(1));
fa017: full_adder port map(p6(4), p7(3), p8(2), s1(2), c1(2));
ha003: half_adder port map(p9(1), p10(0), s1(3), c1(3));
fa018: full_adder port map(p0(11), p1(10), p2(9), s1(4), c1(4));
fa019: full_adder port map(p3(8), p4(7), p5(6), s1(5), c1(5));
fa020: full_adder port map(p6(5), p7(4), p8(3), s1(6), c1(6));
fa021: full_adder port map(p9(2), p10(1), p11(0), s1(7), c1(7));
fa022: full_adder port map(p0(12), p1(11), p2(10), s1(8), c1(8));
fa023: full_adder port map(p3(9), p4(8), p5(7), s1(9), c1(9));
fa024: full_adder port map(p6(6), p7(5), p8(4), s1(10), c1(10));
fa025: full_adder port map(p9(3), p10(2), p11(1), s1(11), c1(11));
fa026: full_adder port map(p0(13), p1(12), p2(11), s1(12), c1(12));
fa027: full_adder port map(p3(10), p4(9), p5(8), s1(13), c1(13));
fa028: full_adder port map(p6(7), p7(6), p8(5), s1(14), c1(14));
fa029: full_adder port map(p9(4), p10(3), p11(2), s1(15), c1(15));
ha004: half_adder port map(p12(1), p13(0), s1(16), c1(16));
fa030: full_adder port map(p0(14), p1(13), p2(12), s1(17), c1(17));

fa031: full_adder port map(p3(11), p4(10), p5(9), s2(0), c2(0));
fa032: full_adder port map(p6(8), p7(7), p8(6), s2(1), c2(1));
fa033: full_adder port map(p9(5), p10(4), p11(3), s2(2), c2(2));
fa034: full_adder port map(p12(2), p13(1), p14(0), s2(3), c2(3));
fa035: full_adder port map(p0(15), p1(14), p2(13), s2(4), c2(4));
fa036: full_adder port map(p3(12), p4(11), p5(10), s2(5), c2(5));
fa037: full_adder port map(p6(9), p7(8), p8(7), s2(6), c2(6));
fa038: full_adder port map(p9(6), p10(4), p11(5), s2(7), c2(7));
fa039: full_adder port map(p12(3), p13(2), p14(1), s2(8), c2(8));
fa040: full_adder port map(p1(15), p2(14), p3(13), s2(9), c2(9));
fa041: full_adder port map(p4(12), p5(11), p6(10), s2(10), c2(10));
fa042: full_adder port map(p7(9), p8(8), p9(7), s2(11), c2(11));
fa043: full_adder port map(p10(6), p11(4), p12(5), s2(12), c2(12));
fa044: full_adder port map(p13(3), p14(2), p15(1), s2(13), c2(13));
fa045: full_adder port map(p2(15), p3(14), p4(13), s2(14), c2(14));
fa046: full_adder port map(p5(12), p6(11), p7(10), s2(15), c2(15));
fa047: full_adder port map(p8(9), p9(8), p10(7), s2(16), c2(16));
fa048: full_adder port map(p11(6), p12(5), p13(4), s2(17), c2(17));

ha005: half_adder port map(p14(3), p15(2), s3(0), c3(0));
fa049: full_adder port map(p3(15), p4(14), p5(13), s3(1), c3(1));
fa050: full_adder port map(p6(12), p7(11), p8(10), s3(2), c3(2));
fa051: full_adder port map(p9(9), p10(8), p11(7), s3(3), c3(3));
fa052: full_adder port map(p12(6), p13(5), p14(4), s3(4), c3(4));
fa053: full_adder port map(p4(15), p5(14), p6(13), s3(5), c3(5));
fa054: full_adder port map(p7(12), p8(11), p9(10), s3(6), c3(6));
fa055: full_adder port map(p10(9), p11(8), p12(7), s3(7), c3(7));
fa056: full_adder port map(p13(6), p14(5), p15(4), s3(8), c3(8));
fa057: full_adder port map(p5(15), p6(14), p7(13), s3(9), c3(9));
fa058: full_adder port map(p8(12), p9(11), p10(10), s3(10), c3(10));
fa059: full_adder port map(p11(9), p12(8), p13(7), s3(11), c3(11));
ha006: half_adder port map(p14(6), p15(5), s3(12), c3(12));
fa060: full_adder port map(p6(15), p7(14), p8(13), s3(13), c3(13));
fa061: full_adder port map(p9(12), p10(11), p11(10), s3(14), c3(14));
fa062: full_adder port map(p12(9), p13(8), p14(7), s3(15), c3(15));
fa063: full_adder port map(p7(15), p8(14), p9(13), s3(16), c3(16));
fa064: full_adder port map(p10(12), p11(11), p12(10), s3(17), c3(17));

fa065: full_adder port map(p13(9), p14(8), p15(7), s4(0), c4(0));
fa066: full_adder port map(p8(15), p9(14), p10(13), s4(1), c4(1));
fa067: full_adder port map(p11(12), p12(11), p13(10), s4(2), c4(2));
ha007: half_adder port map(p14(9), p15(8), s4(3), c4(3));
fa068: full_adder port map(p9(15), p10(14), p11(13), s4(4), c4(4));
fa069: full_adder port map(p12(12), p13(11), p14(10), s4(5), c4(5));
fa070: full_adder port map(p10(15), p11(14), p12(13), s4(6), c4(6));
fa071: full_adder port map(p13(12), p14(11), p15(10), s4(7), c4(7));
fa072: full_adder port map(p11(15), p12(14), p13(13), s4(8), c4(8));
ha008: half_adder port map(p14(12), p15(11), s4(9), c4(9));
fa073: full_adder port map(p12(15), p13(14), p14(13), s4(10), c4(10));
fa074: full_adder port map(p13(15), p14(14), p15(13), s4(11), c4(11));
ha009: half_adder port map(p14(15), p15(14), s4(12), c4(12));

-- Segunda etapa
ha010: half_adder port map(s0(1), c0(0), s4(13), c4(13));
fa075: full_adder port map(s0(2), p3(0), c0(1), s4(14), c4(14));
fa076: full_adder port map(s0(5), s0(6), c0(3), s4(15), c4(15));
fa077: full_adder port map(s0(7), s0(8), p6(0), s4(16), c4(16));
ha011: half_adder port map(c0(5), c0(6), s4(17), c4(17));

fa078: full_adder port map(s0(9), s0(10), s0(11), s5(0), c5(0));
ha012: half_adder port map(c0(7), c0(8), s5(1), c5(1));
fa079: full_adder port map(s0(12), s0(13), s0(14), s5(2), c5(2));
fa080: full_adder port map(c0(9), c0(10), c0(11), s5(3), c5(3));
fa081: full_adder port map(s0(15), s0(16), s0(17), s5(4), c5(4));
fa082: full_adder port map(p9(0), c0(12), c0(13), s5(5), c5(5));
fa083: full_adder port map(s1(0), s1(1), s1(2), s5(6), c5(6));
fa084: full_adder port map(s1(3), c0(15), c0(16), s5(7), c5(7));
fa085: full_adder port map(s1(4), s1(5), s1(6), s5(8), c5(8));
fa086: full_adder port map(s1(7), c1(0), c1(1), s5(9), c5(9));
ha013: half_adder port map(c1(2), c1(3), s5(10), c5(10));
fa087: full_adder port map(s1(8), s1(9), s1(10), s5(11), c5(11));
fa088: full_adder port map(s1(11), p12(0), c1(4), s5(12), c5(12));
fa089: full_adder port map(c1(5), c1(6), c1(7), s5(13), c5(13));
fa090: full_adder port map(s1(12), s1(13), s1(14), s5(14), c5(14));
fa091: full_adder port map(s1(15), s1(16), c1(8), s5(15), c5(15));
fa092: full_adder port map(c1(9), c1(10), c1(11), s5(16), c5(17));
fa093: full_adder port map(s1(17), s2(0), s2(1), s5(17), c5(17));

fa094: full_adder port map(s2(2), s2(3), c1(12), s6(0), c6(0));
fa095: full_adder port map(c1(13), c1(14), c1(15), s6(1), c6(1));
fa096: full_adder port map(s2(4), s2(5), s2(6), s6(2), c6(2));
fa097: full_adder port map(s2(7), s2(8), p15(0), s6(3), c6(3));
fa098: full_adder port map(c1(17), c2(0), c2(1), s6(4), c6(4));
ha014: half_adder port map(c2(2), c2(3), s6(5), c6(5));
fa099: full_adder port map(s2(9), s2(10), s2(11), s6(6), c6(6));
fa100: full_adder port map(s2(12), s2(13), c2(4), s6(7), c6(7));
fa101: full_adder port map(c2(5), c2(6), c2(7), s6(8), c6(8));
fa102: full_adder port map(s2(14), s2(15), s2(16), s6(9), c6(9));
fa103: full_adder port map(s2(17), s3(0), c2(9), s6(10), c6(10));
fa104: full_adder port map(c2(10), c2(11), c2(12), s6(11), c6(11));
fa105: full_adder port map(s3(1), s3(2), s3(3), s6(12), c6(12));
fa106: full_adder port map(s3(4), p15(3), c2(14), s6(13), c6(13));
fa107: full_adder port map(c2(15), c2(16), c2(17), s6(14), c6(14));
fa108: full_adder port map(s3(5), s3(6), s3(7), s6(15), c6(15));
fa109: full_adder port map(s3(8), c3(1), c3(2), s6(16), c6(16));
ha015: half_adder port map(c3(3), c3(4), s6(17), c6(17));

fa110: full_adder port map(s3(9), s3(10), s3(11), s7(0), c7(0));
fa111: full_adder port map(s3(12), c3(5), c3(6), s7(1), c7(1));
ha016: half_adder port map(c3(7), c3(8), s7(2), c7(2));
fa112: full_adder port map(s3(13), s3(14), s3(15), s7(3), c7(3));
fa113: full_adder port map(p15(6), c3(9), c3(10), s7(4), c7(4));
ha017: half_adder port map(c3(11), c3(12), s7(5), c7(5));
fa114: full_adder port map(s3(16), s3(17), s4(0), s7(6), c7(6));
fa115: full_adder port map(c3(13), c3(14), c3(15), s7(7), c7(7));
fa116: full_adder port map(s4(1), s4(2), s4(3), s7(8), c7(8));
fa117: full_adder port map(c3(16), c3(17), c4(0), s7(9), c7(9));
fa118: full_adder port map(s4(4), s4(5), p15(9), s7(10), c7(10));
fa119: full_adder port map(c4(1), c4(2), c4(3), s7(11), c7(11));
fa120: full_adder port map(s4(6), s4(7), c4(4), s7(12), c7(12));
fa121: full_adder port map(s4(8), s4(9), c4(6), s7(13), c7(13));
fa122: full_adder port map(s4(10), p15(12), c4(8), s7(14), c7(14));
ha018: half_adder port map(s4(11), c4(10), s7(15), c7(15));
ha019: half_adder port map(s4(12), c4(11), s7(16), c7(16));
ha020: half_adder port map(p15(15), c4(12), s7(17), c7(17));

-- Tercera etapa
ha021: half_adder port map(s4(14), c4(13), s8(0), c8(0));
ha022: half_adder port map(s4(15), c4(14), s8(1), c8(1));
fa123: full_adder port map(s4(16), c0(4), c4(15), s8(2), c8(2));
fa124: full_adder port map(s4(17), s5(0), c4(16), s8(3), c8(3));
fa125: full_adder port map(s5(1), s5(2), c4(17), s8(4), c8(4));
fa126: full_adder port map(s5(3), s5(4), c5(1), s8(5), c8(5));
fa127: full_adder port map(s5(5), s5(6), c0(14), s8(6), c8(6));
ha023: half_adder port map(c5(3), c5(4), s8(7), c8(7));
fa128: full_adder port map(s5(7), s5(8), c0(17), s8(8), c8(8));
ha024: half_adder port map(c5(5), c5(6), s8(9), c8(9));
fa129: full_adder port map(s5(9), s5(10), s5(11), s8(10), c8(10));
ha025: half_adder port map(c5(7), c5(8), s8(11), c8(11));
fa130: full_adder port map(s5(12), s5(13), s5(14), s8(12), c8(12));
fa131: full_adder port map(c5(9), c5(10), c5(11), s8(13), c8(13));
fa132: full_adder port map(s5(15), s5(16), s5(17), s8(14), c8(14));
fa133: full_adder port map(c5(12), c5(13), c5(14), s8(15), c8(15));
fa134: full_adder port map(s6(0), s6(1), s6(2), s8(16), c8(16));
fa135: full_adder port map(c1(16), c5(15), c5(16), s8(17), c8(17));

fa136: full_adder port map(s6(3), s6(4), s6(5), s9(0), c9(0));
fa137: full_adder port map(s6(6), c6(0), c6(1), s9(1), c9(1));
fa138: full_adder port map(s6(7), s6(8), s6(9), s9(2), c9(2));
fa139: full_adder port map(c2(8), c6(3), c6(4), s9(3), c9(3));
ha026: half_adder port map(c6(5), c6(6), s9(4), c9(4));
fa140: full_adder port map(s6(10), s6(11), s6(12), s9(5), c9(5));
fa141: full_adder port map(c2(13), c6(7), c6(8), s9(6), c9(6));
fa142: full_adder port map(s6(13), s6(14), s6(15), s9(7), c9(7));
fa143: full_adder port map(c3(0), c6(10), c6(11), s9(8), c9(8));
fa144: full_adder port map(s6(16), s6(17), s7(0), s9(9), c9(9));
fa145: full_adder port map(c6(13), c6(14), c6(15), s9(10), c9(10));
fa146: full_adder port map(s7(1), s7(2), s7(3), s9(11), c9(11));
fa147: full_adder port map(c6(16), c6(17), c7(0), s9(12), c9(12));
fa148: full_adder port map(s7(4), s7(5), s7(6), s9(13), c9(13));
fa149: full_adder port map(c7(1), c7(2), c7(3), s9(14), c9(14));
fa150: full_adder port map(s7(7), s7(8), c7(4), s9(15), c9(15));
ha027: half_adder port map(c7(5), c7(6), s9(16), c9(16));
fa151: full_adder port map(s7(9), s7(10), c7(7), s9(17), c9(17));

fa152: full_adder port map(s7(11), s7(12), c7(9), s10(0), c10(0));
fa153: full_adder port map(s7(13), c4(5), c7(11), s10(1), c10(1));
fa154: full_adder port map(s7(14), c4(7), c7(13), s10(2), c10(2));
fa155: full_adder port map(s7(15), c4(9), c7(14), s10(3), c10(3));
ha028: half_adder port map(s7(16), c7(15), s10(4), c10(4));
ha029: half_adder port map(s7(17), c7(16), s10(5), c10(5));

-- Cuarta etapa
ha030: half_adder port map(s8(1), c8(0), s10(6), c10(6));
ha031: half_adder port map(s8(2), c8(1), s10(7), c10(7));
ha032: half_adder port map(s8(3), c8(2), s10(8), c10(8));
fa156: full_adder port map(s8(4), c5(0), c8(3), s10(9), c10(9));
fa157: full_adder port map(s8(5), c5(2), c8(4), s10(10), c10(10));
fa158: full_adder port map(s8(6), s8(7), c8(5), s10(11), c10(11));
fa159: full_adder port map(s8(8), s8(9), c8(6), s10(12), c10(12));
fa160: full_adder port map(s8(10), s8(11), c8(8), s10(13), c10(13));
fa161: full_adder port map(s8(12), s8(13), c8(10), s10(14), c10(14));
fa162: full_adder port map(s8(14), s8(15), c8(12), s10(15), c10(15));
fa163: full_adder port map(s8(16), s8(17), c5(17), s10(16), c10(16));
ha033: half_adder port map(c8(14), c8(15), s10(17), c10(17));

fa164: full_adder port map(s9(0), s9(1), c6(2), s11(0), c11(0));
ha034: half_adder port map(c8(16), c8(17), s11(1), c11(1));
fa165: full_adder port map(s9(2), s9(3), s9(4), s11(2), c11(2));
ha035: half_adder port map(c9(0), c9(1), s11(3), c11(3));
fa166: full_adder port map(s9(5), s9(6), c6(9), s11(4), c11(4));
fa167: full_adder port map(c9(2), c9(3), c9(4), s11(5), c11(5));
fa168: full_adder port map(s9(7), s9(8), c6(12), s11(6), c11(6));
ha036: half_adder port map(c9(5), c9(6), s11(7), c11(7));
fa169: full_adder port map(s9(9), s9(10), c9(7), s11(8), c11(8));
fa170: full_adder port map(s9(11), s9(12), c9(9), s11(9), c11(9));
fa171: full_adder port map(s9(13), s9(14), c9(11), s11(10), c11(10));
fa172: full_adder port map(s9(15), s9(16), c9(13), s11(11), c11(11));
fa173: full_adder port map(s9(17), c7(8), c9(15), s11(12), c11(12));
fa174: full_adder port map(s10(0), c7(10), c9(17), s11(13), c11(13));
fa175: full_adder port map(s10(1), c7(12), c10(0), s11(14), c11(14));
ha037: half_adder port map(s10(2), c10(1), s11(15), c11(15));
ha038: half_adder port map(s10(3), c10(2), s11(16), c11(16));
ha039: half_adder port map(s10(4), c10(3), s11(17), c11(17));

ha040: half_adder port map(s10(5), c10(4), s12(0), c12(0));
ha041: half_adder port map(c7(17), c10(5), s12(1), c12(1));

-- Quinta etapa
ha042: half_adder port map(s10(7), c10(6), s12(2), c12(2));
ha043: half_adder port map(s10(8), c10(7), s12(3), c12(3));
ha044: half_adder port map(s10(9), c10(8), s12(4), c12(4));
ha045: half_adder port map(s10(10), c10(9), s12(5), c12(5));
ha046: half_adder port map(s10(11), c10(10), s12(6), c12(6));
fa176: full_adder port map(s10(12), c7(7), c10(11), s12(7), c12(7));
fa177: full_adder port map(s10(13), c7(9), c10(12), s12(8), c12(8));
fa178: full_adder port map(s10(14), c7(11), c10(13), s12(9), c12(9));
fa179: full_adder port map(s10(15), c7(13), c10(14), s12(10), c12(10));
fa180: full_adder port map(s10(16), s10(17), c10(15), s12(11), c12(11));
fa181: full_adder port map(s11(0), s10(1), c10(10), s12(12), c12(12));
fa182: full_adder port map(s11(2), s11(3), c11(0), s12(13), c12(13));
fa183: full_adder port map(s11(4), s11(5), c11(2), s12(14), c12(14));
fa184: full_adder port map(s11(6), s11(7), c11(4), s12(15), c12(15));
fa185: full_adder port map(s11(8), c9(8), c11(6), s12(16), c12(16));
fa186: full_adder port map(s11(9), c9(10), c11(8), s12(17), c12(17));

fa187: full_adder port map(s11(10), c9(12), c11(9), s13(0), c13(0));
fa188: full_adder port map(s11(11), c9(14), c11(10), s13(1), c13(1));
fa189: full_adder port map(s11(12), c9(16), c11(11), s13(2), c13(2));
ha047: half_adder port map(s11(13), c11(12), s13(3), c13(3));
ha048: half_adder port map(s11(14), c11(13), s13(4), c13(4));
ha049: half_adder port map(s11(15), c11(14), s13(5), c13(5));
ha050: half_adder port map(s11(16), c11(15), s13(6), c13(6));
ha051: half_adder port map(s11(17), c11(16), s13(7), c13(7));
ha052: half_adder port map(s12(0), c11(17), s13(8), c13(8));
ha053: half_adder port map(s12(1), c12(0), s13(9), c13(9));

-- Sexta etapa
ha053: half_adder port map(s12(1), c12(0), s13(10), c13(10));
ha053: half_adder port map(s12(1), c12(0), s13(11), c13(11));
ha053: half_adder port map(s12(1), c12(0), s13(12), c13(12));
ha053: half_adder port map(s12(1), c12(0), s13(13), c13(13));
ha053: half_adder port map(s12(1), c12(0), s13(14), c13(14));
ha053: half_adder port map(s12(1), c12(0), s13(15), c13(15));
ha053: half_adder port map(s12(1), c12(0), s13(16), c13(16));
ha053: half_adder port map(s12(1), c12(0), s13(17), c13(17));
ha053: half_adder port map(s12(1), c12(0), s13(9), c13(9));

end Behavioral;
