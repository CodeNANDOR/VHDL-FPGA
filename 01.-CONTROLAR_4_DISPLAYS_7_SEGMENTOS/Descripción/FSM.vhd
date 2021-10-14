--Dispositivos Digitales Programables.
--Code NANDOR.
--Lenguaje de Hardware: VHDL.
--Descripción: FSM encargada de sincronizar todo el sistema.

--Autor de Código: 
	--Ing. Herrera Palacios Luis Fernando.
	
--Control de versiones:
    --Primera Revisión:(09/oct/2021).
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
    Port ( clk : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           SEL : out  STD_LOGIC_VECTOR (1 downto 0);
           Enable : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

type FSM is (UNO,DOS,TRES,CUATRO);
signal edo_pre,edo_fut:FSM:=UNO;

signal Enable_S : STD_LOGIC:='0';

begin

FSM_Display:process(edo_pre)
begin
	case edo_pre is
		when UNO => SEL <= "00"; 
			edo_fut <= DOS;
		when DOS => SEL <= "01";
			edo_fut <= TRES;	
		when TRES => SEL <= "10";
			edo_fut <= CUATRO;			
		when others => SEL <= "11";
			edo_fut <= UNO;
	end case;
end process FSM_Display;

Trans_FSM:process(clk)
begin
	if(rising_edge(clk))then
		if(RESET = '1')then
			edo_pre <= UNO;
			Enable_S <= '1'; 
		else
			edo_pre <= edo_fut;
			Enable_S <= '0'; 
		end if;
	end if;
end process Trans_FSM;

Enable <= Enable_S;

end Behavioral;

