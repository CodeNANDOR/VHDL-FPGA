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
use ieee.numeric_std.all;

entity tb_TOP_DISPLAY_MULTIPLEXOR is
end tb_TOP_DISPLAY_MULTIPLEXOR;

architecture Behavioral of tb_TOP_DISPLAY_MULTIPLEXOR is

component TOP_DISPLAY_MULTIPLEXOR 
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
end component;

signal clk :   STD_LOGIC;
signal reset :   STD_LOGIC;
signal Digito_1 :   STD_LOGIC_VECTOR (3 downto 0);
signal Digito_2 :   STD_LOGIC_VECTOR (3 downto 0);
signal Digito_3 :   STD_LOGIC_VECTOR (3 downto 0);
signal Digito_4 :   STD_LOGIC_VECTOR (3 downto 0);
signal DATAout :   STD_LOGIC_VECTOR (7 downto 0);
signal Y :   STD_LOGIC_VECTOR (3 downto 0);

begin

tb_TOP_DISPLAY_MULTIPLEXOR : TOP_DISPLAY_MULTIPLEXOR
port map(
         clk => clk,
         reset => reset,
         Digito_1 => Digito_1,
         Digito_2 => Digito_2,
         Digito_3 => Digito_3,
         Digito_4 => Digito_4,
         DATAout =>DATAout,
         Y =>Y
         ); 

reset <= '0';
         
clk_simu:process    
begin
    clk <= '0';
    wait for 10ns;
    clk <= '1';
    wait for 10ns;
end process clk_simu;          
         
         
data_simu:process    
begin
         Digito_1 <= std_logic_vector(to_unsigned(1, 4));
         Digito_2 <= std_logic_vector(to_unsigned(3, 4));
         Digito_3 <= std_logic_vector(to_unsigned(5, 4));
         Digito_4 <= std_logic_vector(to_unsigned(9, 4));
         
         wait for 4ms;
         
         Digito_1 <= std_logic_vector(to_unsigned(8, 4));
         Digito_2 <= std_logic_vector(to_unsigned(7, 4));
         Digito_3 <= std_logic_vector(to_unsigned(6, 4));
         Digito_4 <= std_logic_vector(to_unsigned(2, 4));
         
         wait for 4ms;
         
         Digito_1 <= std_logic_vector(to_unsigned(3, 4));
         Digito_2 <= std_logic_vector(to_unsigned(5, 4));
         Digito_3 <= std_logic_vector(to_unsigned(6, 4));
         Digito_4 <= std_logic_vector(to_unsigned(9, 4));
         
         wait for 4ms;
         
         Digito_1 <= std_logic_vector(to_unsigned(4, 4));
         Digito_2 <= std_logic_vector(to_unsigned(6, 4));
         Digito_3 <= std_logic_vector(to_unsigned(9, 4));
         Digito_4 <= std_logic_vector(to_unsigned(1, 4));
         
         wait for 4ms;
         
        assert false -- Secuencia para términar simulación automáticamente (Creamos una falla controlada).
             report "Simulación finalizada."
             severity failure; -- Detenemos la simulación.
         
end process data_simu;  
      
end Behavioral;
