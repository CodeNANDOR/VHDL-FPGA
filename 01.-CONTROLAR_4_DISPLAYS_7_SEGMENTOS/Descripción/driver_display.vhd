--Dispositivos Digitales Programables.
--Code NANDOR.
--Lenguaje de Hardware: VHDL.
--Descripción: Controlador principal de los Displays.

--Autor de Código: 
	--Ing. Herrera Palacios Luis Fernando.
	
--Control de versiones:
    --Primera Revisión:(09/oct/2021).
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity driver_display is
	GENERIC(
			FREQ_CLK_FPGA : integer := 50_000_000     --FRECUENCIA DE LA TARJETA 50MHz.
													  --(Este valor puede variar dependiendo 
													  -- de la frecuencia base del FPGA).
		    );
    Port ( Reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           SEL : out  STD_LOGIC_VECTOR (1 downto 0);
           Enable : out  STD_LOGIC);
end driver_display;

architecture Behavioral of driver_display is

COMPONENT FSM
PORT(
	clk : IN std_logic;
	RESET : IN std_logic;
	Enable : OUT std_logic;          
	SEL : OUT std_logic_vector(1 downto 0)
	);
END COMPONENT;

COMPONENT divisor_frequency
generic(
		FREQ_CLK_FPGA : integer := FREQ_CLK_FPGA  --FRECUENCIA DE LA TARJETA 50MHz.
												  --(Este valor puede variar dependiendo 
												  -- de la frecuencia base del FPGA).
		 );
PORT(
	clk : IN std_logic;  
	DIV_CLOCK : OUT std_logic
	);
END COMPONENT;

--signal
signal clk_div:std_logic:='0';

begin

Inst_FSM: FSM PORT MAP(
	clk => clk_div,
	RESET => RESET,
	SEL => SEL,
	Enable => Enable
);

Inst_divisor_frequency: divisor_frequency generic map(
	FREQ_CLK_FPGA => FREQ_CLK_FPGA
)
PORT MAP(
	clk => clk,
	DIV_CLOCK => clk_div 
);

end Behavioral;

