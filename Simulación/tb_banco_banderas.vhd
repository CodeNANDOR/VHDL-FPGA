library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_banco_banderas is
end tb_banco_banderas;

architecture Behavioral of tb_banco_banderas is

component banco_banderas 
   generic(
           constant CLK_FPGA: integer:= 100_000_000    
           );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Ts  : out STD_LOGIC;
           btime_display  : out STD_LOGIC;
           btime_250ms  : out STD_LOGIC
           );
end component;

--Señales para la simulación.
signal clk,rst,Ts,btime_display,btime_250ms:std_logic:='0';

begin

tb_banco_banderas : banco_banderas
port map(
         clk => clk,
         rst => rst,
         Ts => Ts,
         btime_display => btime_display,
         btime_250ms => btime_250ms
         ); 
        
clk_simu:process    
begin
    clk <= '0';
    wait for 5ns;
    clk <= '1';
    wait for 5ns;
end process clk_simu; 
  
rst_simu:process
begin
    rst <= '0';
    wait for 500ms;
    rst <= '1';
    wait for 10ns;
end process rst_simu;
            
end Behavioral;