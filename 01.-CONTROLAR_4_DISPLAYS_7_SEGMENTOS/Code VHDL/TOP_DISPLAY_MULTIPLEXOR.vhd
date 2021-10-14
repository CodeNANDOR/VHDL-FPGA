--Dispositivos Digitales Programables.
--Code NANDOR.
--Lenguaje de Hardware: VHDL.
--Descripción: Top EStructural para unir todas la entidades de nuestra arquitectura.

--Autor de Código: 
	--Ing. Herrera Palacios Luis Fernando.
	
--Control de versiones:
    --Primera Revisión:(09/oct/2021). 
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_DISPLAY_MULTIPLEXOR is
	generic(
			 FREQ_CLK_FPGA : integer := 50_000_000         	--FRECUENCIA DE LA TARJETA 50MHz.
															--(Este valor puede variar dependiendo 
															-- de la frecuencia base del FPGA).
		    );
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Digito_1 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito_2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito_3 : in  STD_LOGIC_VECTOR (3 downto 0);
           Digito_4 : in  STD_LOGIC_VECTOR (3 downto 0);
           DATAout : out  STD_LOGIC_VECTOR (7 downto 0);
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end TOP_DISPLAY_MULTIPLEXOR;

architecture Behavioral of TOP_DISPLAY_MULTIPLEXOR is

COMPONENT Mux_4to1
PORT(
	Digito_1 : IN std_logic_vector(3 downto 0);
	Digito_2 : IN std_logic_vector(3 downto 0);
	Digito_3 : IN std_logic_vector(3 downto 0);
	Digito_4 : IN std_logic_vector(3 downto 0);
	SEL : IN std_logic_vector(1 downto 0);          
	Digito_Out : OUT std_logic_vector(3 downto 0)
	);
END COMPONENT;
	
COMPONENT decod_2to4
	PORT(
	SEL : IN std_logic_vector(1 downto 0);
	E : IN std_logic;          
	Y : OUT std_logic_vector(3 downto 0)
	);
END COMPONENT;

COMPONENT decod_BCDto7seg
PORT(
	DATAin : IN std_logic_vector(3 downto 0);          
	DATAout : OUT std_logic_vector(7 downto 0)
	);
END COMPONENT;

COMPONENT driver_display
	GENERIC(
			FREQ_CLK_FPGA : integer := FREQ_CLK_FPGA  --FRECUENCIA DE LA TARJETA 50MHz.
													  --(Este valor puede variar dependiendo 
													  -- de la frecuencia base del FPGA).
		    );
	PORT(
		Reset : IN std_logic;
		CLK : IN std_logic;          
		SEL : OUT std_logic_vector(1 downto 0);
		Enable : OUT std_logic
		);
END COMPONENT;

--signal 
signal enable_s:std_logic:='0';
signal sel_s :std_logic_vector(1 downto 0):=(OTHERS => '0');
signal DigitoOut_s :  std_logic_vector(3 downto 0):=(others => '0');

begin

Inst_Mux_4to1: Mux_4to1 PORT MAP(
	Digito_1 => Digito_1,
	Digito_2 => Digito_2,
	Digito_3 => Digito_3,
	Digito_4 => Digito_4,
	SEL => sel_s,
	Digito_Out => DigitoOut_s
);

Inst_decod_2to4: decod_2to4 PORT MAP(
	SEL => sel_s,
	E => enable_s,
	Y => Y
);

Inst_decod_BCDto7seg: decod_BCDto7seg PORT MAP(
	DATAin => DigitoOut_s,
	DATAout => DATAout
);

Inst_driver_display: driver_display GENERIC MAP(
	FREQ_CLK_FPGA => FREQ_CLK_FPGA
)
PORT MAP(
	Reset => reset,
	CLK => clk,
	SEL => sel_s,
	Enable => enable_s
);

end Behavioral;

