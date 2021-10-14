--Dispositivos Digitales Programables.
--Code NANDOR.
--Lenguaje de Hardware: VHDL.
--Descripción:Decodificador 2 a 4.

--Autor de Código: 
	--Ing. Herrera Palacios Luis Fernando.
	
--Control de versiones:
    --Primera Revisión:(09/oct/2021).
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decod_2to4 is
    Port ( SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           E : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end decod_2to4;

architecture Behavioral of decod_2to4 is

begin

DECOD_2A4: PROCESS(SEL,E)
BEGIN
	IF(E = '1')THEN
			Y <= ("1111");
	ELSE
			CASE SEL IS                 
				  WHEN "00" => Y <= ("1110"); --0
				  WHEN "01" => Y <= ("1101"); --1
				  WHEN "10" => Y <= ("1011"); --2
				  WHEN OTHERS => Y <= ("0111"); --3
			END CASE;
	END IF;
END PROCESS DECOD_2A4;

end Behavioral;

