--Dispositivos Digitales Programables.
--Code NANDOR.
--Lenguaje de Hardware: VHDL.
--Descripción:  Divisor requerido para bajar la frecuencia base de 
				 --50 MHz(La del FPGA) a 1KHz(Multiplexado de Displays).

--Autor de Código: 
	--Ing. Herrera Palacios Luis Fernando.
	
--Control de versiones:
    --Primera Revisión:(09/oct/2021).
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_frequency is
	generic(
			FREQ_CLK_FPGA : integer := 50_000_000;    --FRECUENCIA DE LA TARJETA 50MHz.
													  --(Este valor puede variar dependiendo 
													  -- de la frecuencia base del FPGA).
			FREQ_DISPLAY : Integer:= 1000			  --Frecuencia requerida para hacer la division de frecuencia 
													  --de 50,000,000 Hz (Frecuencia Base) a 1000Hz(Multiplexacion de Displays) 
		   );
		    
    Port ( clk : in  STD_LOGIC;           
           DIV_CLOCK : out  STD_LOGIC);
end divisor_frequency;

architecture Behavioral of divisor_frequency is

--Constantes
constant MAX_count : integer:=((FREQ_CLK_FPGA/FREQ_DISPLAY)-1); 

--Signals
signal count_div_freq :integer range 0 to MAX_count:=0;
signal clk_div : std_logic := '0';

begin

div_freq:process(clk)
begin

	if(rising_edge(clk)) then
				if(count_div_freq = MAX_count)then
				  clk_div <= '1';
				  count_div_freq <= 0;
				else
				  clk_div <= '0';
				  count_div_freq <= count_div_freq + 1;
				end if;
	end if;
		
end process div_freq;

DIV_CLOCK <= clk_div;

end Behavioral;

