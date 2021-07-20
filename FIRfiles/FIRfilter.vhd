library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity FIRfilter is

    generic(input_length : INTEGER:=8;
            output_length: INTEGER:=16;
            coeff_length:  INTEGER:=8;
            taps: INTEGER:=4
    );

    port(in1: in std_logic_vector(input_length-1 downto 0);
         clk: in std_logic;
         rst: in std_logic;
         out1: out std_logic_vector(output_length-1 downto 0)
    );

end FIRfilter;


architecture Behavioral of FIRfilter is


component bitregister is
     generic(length: INTEGER:= 8);

    PORT(D: in STD_LOGIC_VECTOR(length-1 downto 0);
         rst,clk: in std_logic;
         Q: out STD_LOGIC_VECTOR(length-1 downto 0)
    );
end component;

component Wallace8 is
 Port ( A,B : in STD_LOGIC_VECTOR (7 downto 0);
           prod : out STD_LOGIC_VECTOR (15 downto 0));
end component;   
    
TYPE coeff_type is array(1 to taps) of std_logic_vector(coeff_length-1 downto 0);
constant coefficients: coeff_type:= (X"F1",X"F3",X"07",X"06");

TYPE shift_type is array(0 to taps-1) of std_logic_vector(input_length-1 downto 0);
signal shift_reg: shift_type;

TYPE mult_type is array(0 to taps-1) of std_logic_vector(input_length+coeff_length-1 downto 0);
signal mul_reg: mult_type;

TYPE add_type is array(0 to taps-1) of std_logic_vector(input_length+coeff_length-1 downto 0);
signal add_reg: add_type;


begin

shift_reg(0)<=in1;
multiplicacion: Wallace8 port map(in1,coefficients(1),mul_reg(0));
adicion: Wallace8 port map(in1,coefficients(1),add_reg(0));

generating_fir: FOR I IN 0 TO taps-2 GENERATE
    begin
    
        Registros: bitregister generic map (8)
        port map(clk=>clk,
                 rst=>rst,
                 D => shift_reg(i),
                 Q=> shift_reg(i+1)
        );
        
        multi2: Wallace8 port map (shift_reg(i+1),coefficients(i+1),mul_reg(i+1));
        add_reg(i+1)<= add_reg(i)+mul_reg(i+1);

end generate generating_fir;

out1<= add_reg(taps-1);

end Behavioral;
