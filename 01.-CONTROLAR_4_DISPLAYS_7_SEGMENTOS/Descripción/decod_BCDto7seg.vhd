--Dispositivos Digitales Programables.
--Code NANDOR.
--Lenguaje de Hardware: VHDL.
--Descripción: Decodificador BCD a 7 segmentos. En este caso tomamos 8 bits
				--(1 Byte) para el bus de datos de los displays, porque son 7 segmentos 
				--y el punto decimal.

--Autor de Código: 
	--Ing. Herrera Palacios Luis Fernando.
	
--Control de versiones:
    --Primera Revisión:(09/oct/2021).
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decod_BCDto7seg is
    Port ( DATAin : in  STD_LOGIC_VECTOR (3 downto 0);
           DATAout : out  STD_LOGIC_VECTOR (7 downto 0));
end decod_BCDto7seg;

architecture Behavioral of decod_BCDto7seg is

begin

TABLA_VERDAD: PROCESS(DATAin)
BEGIN
     CASE DATAin IS                  --ABCDEFG.
        WHEN "0000" => DATAout <= not("11111100"); --0
        WHEN "0001" => DATAout <= not("01100000"); --1
        WHEN "0010" => DATAout <= not("11011010"); --2
        WHEN "0011" => DATAout <= not("11110010"); --3
        WHEN "0100" => DATAout <= not("01100110"); --4
        WHEN "0101" => DATAout <= not("10110110"); --5
        WHEN "0110" => DATAout <= not("10111110"); --6
        WHEN "0111" => DATAout <= not("11100000"); --7
        WHEN "1000" => DATAout <= not("11111110"); --8
        WHEN "1001" => DATAout <= not("11100110"); --9
        WHEN OTHERS => DATAout <= not("00000000"); --Segmento G
     END CASE;
END PROCESS TABLA_VERDAD;
		  
end Behavioral;

