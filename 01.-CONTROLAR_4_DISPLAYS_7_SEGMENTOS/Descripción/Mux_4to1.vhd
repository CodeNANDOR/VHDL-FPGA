--Dispositivos Digitales Programables.
--Code NANDOR.
--Lenguaje de Hardware: VHDL.
--Descripción: Multiplexor 4 a 1 de 4 bits de ancho.

--Autor de Código: 
	--Ing. Herrera Palacios Luis Fernando.
	
--Control de versiones:
    --Primera Revisión:(09/oct/2021).
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_4to1 is
    Port ( Digito_1 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito_2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito_3 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito_4 : in  STD_LOGIC_VECTOR (3 downto 0);
           SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           Digito_Out : out  STD_LOGIC_VECTOR (3 downto 0));
end Mux_4to1;

architecture Behavioral of Mux_4to1 is

begin

with SEL select
	Digito_Out <= 	Digito_1 when "00",
						Digito_2 when "01",
						Digito_3 when "10",
						Digito_4 when others;

end Behavioral;

