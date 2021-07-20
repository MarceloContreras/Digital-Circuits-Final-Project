LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

entity booth_multiplier2 is

	generic (A : INTEGER := 16;
		 B : INTEGER := 16);
	
	port(m : in std_logic_vector(a - 1 downto 0);
	     r : in std_logic_vector(b - 1 downto 0);
	     multip : out std_logic_vector(a + b - 1 downto 0));
		  
end booth_multiplier2;

architecture behavior of booth_multiplier2 is

signal a1, s, prod : std_logic_vector(a + b + 1 downto 0);
signal n: std_logic_vector(a - 1 downto 0);


begin
	
	PROCESS(m, r)
		
		constant A_Z : STD_LOGIC_VECTOR(A - 1 downto 0) := (OTHERS => '0');
		constant B_Z : STD_LOGIC_VECTOR(B - 1 downto 0) := (OTHERS => '0');
	
	begin
		
		a1 <= (OTHERS => '0');
		s <= (OTHERS => '0');
		prod <= (OTHERS => '0');
		
		if (m /= A_Z and r /= B_Z) then
			
			a1(A + B downto B + 1) <= m;
			a1(A + B + 1) <= m(A - 1);
			
			n <= (NOT m) + 1;
			
			s(A + B downto B + 1) <= n;
			s(A + B + 1) <= NOT(m(A - 1));
			
			prod(B downto 1) <= r;
			
			for i in 1 to B loop
				
				if (prod(1 downto 0) = "01") then
					prod <= prod + a1;
				elsif (prod(1 downto 0) = "10") then
					prod <= prod + s;
				end if;
				
				-- Shift Right Arithmetic
				prod(A + B downto 0) <= prod(A + B + 1 downto 1);
			
			end loop;
			
		end if;
		
		multip <= prod(A + B downto 1);
		
	end process;
	
END behavior;