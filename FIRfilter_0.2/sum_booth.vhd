library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.ALL;

entity booth_multiplier is

	GENERIC (L : INTEGER := 16);
	
	PORT(m : IN std_logic_vector(L- 1 downto 0);
	     r : IN std_logic_vector(L - 1 downto 0);
	     prod : OUT std_logic_vector(2*L - 1 downto 0));
		  
end booth_multiplier;

architecture behavior of booth_multiplier is

begin
	
process(m, r)

	constant X_ZEROS : std_logic_vector(L - 1 downto 0) := (others => '0');
	constant Y_ZEROS : std_logic_vector(L - 1 downto 0) := (others => '0');

	variable a, s, p : std_logic_vector(2*L + 1 downto 0);
	variable mn      : std_logic_vector(L - 1 downto 0);

begin
	
-- Inicializacion de variables
	a := (others  => '0');
	s := (others  => '0');
	p := (others  => '0');

-- Conteo de operaciones restantes y complemento
	if (m /= X_ZEROS AND r /= Y_ZEROS) then

		a(2*L downto L + 1) := m;
		a(2*L + 1) := m(L - 1);

		mn := (not m) + 1;

		s(2*L downto L + 1) := mn;
		s(2*L + 1) := NOT(m(L - 1));

		p(L downto 1) := r;

-- Operación suma o resta

		for i in 1 to L loop

			if (p(1 downto 0) = "01") then
				p := p + a;
			elsif (p(1 downto 0) = "10") then
				p := p + s;
			end if;

-- Shifting
			p(2*L downto 0) := p(2*L + 1 downto 1);

		end loop;

	end if;

	prod <= p(2*L downto 1);

end process;
	
end behavior;
