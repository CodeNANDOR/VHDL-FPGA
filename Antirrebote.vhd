library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Antirrebote is
					generic(
								FREQ_CLK : integer := 50_000_000   --FRECUENCIA DEL FPGA
							  );
					
					port(	Boton: in std_logic;
							CLK_FPGA: in std_logic;
							LED: out std_logic
						  );
end Antirrebote;

architecture Behavioral of Antirrebote is

--DIVISOR DE FRECUENCIA.
constant DELAY_5ms:integer:=(FREQ_CLK/200)-1;
signal COUNT_5ms:integer range 0 to DELAY_5ms:=0;
signal BANDERA:std_logic:='0';

--CONTADOR QUE ELIMINA EL RUIDO AL PULSAR EL PUSH BUTTON.
SIGNAL REG_RUIDO : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS=>'0');

--DECLARACION DE LA MAQUINA DE ESTADO ASM.
type CARTA_ASM is (A,B,C,D);
signal edo_pre,edo_fut : CARTA_ASM;

begin

--==================================================================================================================================================
--*                            				PROCESO ENCARGADO DE ACTIVAR Y DESACTIVAR LA BANDERA.                             																							    *--
--==================================================================================================================================================

Divisor_de_Frecuencia:process(CLK_FPGA)
begin
			if(rising_edge(CLK_FPGA))then
						if(COUNT_5ms = DELAY_5ms)then
								COUNT_5ms <= 0;
								BANDERA <= '1';
						else 
								COUNT_5ms <= COUNT_5ms + 1;
								BANDERA <= '0';
						end if;
			end if;
end process Divisor_de_Frecuencia;



--==================================================================================================================================================
--*                      PROCESO QUE SE ENCARGA DE LLENAR EL REGISTRO QUE ELIMINA EL RUIDO AL PRESIONAR EL PUSH BUTTON.                           																							    *--
--==================================================================================================================================================

Filtro_de_ruido : process(CLK_FPGA,BANDERA)
begin
			if(rising_edge(CLK_FPGA) and (BANDERA = '1'))then
				REG_RUIDO <= (REG_RUIDO(6 downto 0))&(Boton);
			end if;
end process Filtro_de_ruido;

--==================================================================================================================================================
--*           ALGORITO DE LA MAQUINA DE ESTADO ASM QUE EVITA FILTRACIONES DE PULSOS NO DESEADOS <-----> MODELO MOORE                             																							    *--
--==================================================================================================================================================

Maquina_Estado_ASM_Push:process(edo_pre,REG_RUIDO)
begin
			case edo_pre is
				when A => LED <= '0';
				
						if(REG_RUIDO = x"FF")then
						edo_fut <= B;
						else
						edo_fut <= A;
						end if;
								 
				when B => LED <= '0';
	
						if(REG_RUIDO /= x"FF")then
						edo_fut <= C;
						else
						edo_fut <= B;
						end if;
									
				when C => LED <= '1';
				
						if(REG_RUIDO = x"FF")then
						edo_fut <= D;
						else
						edo_fut <= C;
						end if;		
								 
				when others => LED <= '1';
				
						if(REG_RUIDO /= x"FF")then
						edo_fut <= A;
						else
						edo_fut <= D;
						end if;
						
			end case;
end process Maquina_Estado_ASM_Push;

Asigna_Estado_ASM:process(CLK_FPGA)
begin
			if(rising_edge(CLK_FPGA))then
						edo_pre <= edo_fut;
			end if;
end process Asigna_Estado_ASM;


end Behavioral;

