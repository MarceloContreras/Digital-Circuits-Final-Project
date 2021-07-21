library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.ALL;

entity booth_multiplier is

	GENERIC (x : INTEGER := 16;
		 y : INTEGER := 16);
	
	PORT(m : IN std_logic_vector(x - 1 downto 0);
	     r : IN std_logic_vector(y - 1 downto 0);
	     prod : OUT std_logic_vector(x + y - 1 downto 0));
		  
end booth_multiplier;

architecture behavior of booth_multiplier is

begin
	
process(m, r)

	constant X_ZEROS : std_logic_vector(x - 1 downto 0) := (others => '0');
	constant Y_ZEROS : std_logic_vector(y - 1 downto 0) := (others => '0');

	variable a, s, p : std_logic_vector(x + y + 1 downto 0);
	variable mn      : std_logic_vector(x - 1 downto 0);

begin
	
-- Inicializacion de variables
	a := (others  => '0');
	s := (others  => '0');
	p := (others  => '0');

-- Conteo de operaciones restantes y complemento
	if (m /= X_ZEROS AND r /= Y_ZEROS) then

		a(x + y downto y + 1) := m;
		a(x + y + 1) := m(x - 1);

		mn := (not m) + 1;

		s(x + y downto y + 1) := mn;
		s(x + y + 1) := NOT(m(x - 1));

		p(y downto 1) := r;

-- Operación suma o resta

		for i in 1 to y loop

			if (p(1 downto 0) = "01") then
				p := p + a;
			elsif (p(1 downto 0) = "10") then
				p := p + s;
			end if;

-- Shifting
			p(x + y downto 0) := p(x + y + 1 downto 1);

		end loop;

	end if;

	prod <= p(x + y downto 1);

end process;
	
end behavior;
