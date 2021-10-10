
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_pid_controller is
end tb_pid_controller;

architecture Behavioral of tb_pid_controller is

component pid_controller 
    Port ( clk : in STD_LOGIC;
           R : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           start : in STD_LOGIC;
           ena : in STD_LOGIC;
           rst : in STD_LOGIC;
           V : out STD_LOGIC_VECTOR (15 downto 0)); --Salida de señal de control (V) 
                                                    --en formato de punto fijo [7.9]
end component;

--Señales para simulación.
signal clk,start,ena,rst,Select_method:std_logic:='0';
signal R,B : STD_LOGIC_VECTOR (11 downto 0):=(others => '0');
signal V : STD_LOGIC_VECTOR (15 downto 0):=(others => '0');

begin

tb_pid_controller : pid_controller
port map(
         clk => clk,
         R => R,
         B => B,
         start => start,
         ena => ena,
         rst => rst,
         V => V
         );
         
rst <= '0';
ena <= '1';      
   
process    
begin
    clk <= '0';
    wait for 5ns;
    clk <= '1';
    wait for 5ns;
end process; 

process  --Ts = 100ms;
begin
    start <= '0';
    wait for 99_999_990ns;
    start <= '1';
    wait for 10ns;
end process;

process   --Tiempo total de simulación: 1,200ms
begin

-- E = R - B    E = 0  
R <= x"000"; 
B <= x"000"; 
wait for 100ms;
-- E = R - B    E = -100.0  
R <= x"000"; 
B <= x"640"; 
wait for 100ms;
-- E = R - B    E = -60.000 
R <= x"000"; 
B <= x"3C0"; 
wait for 100ms;
-- E = R - B    E = -20.06250 
R <= x"000";   
B <= x"141"; 
wait for 100ms;
-- E = R - B    E = 19.93750 
R <= x"000"; 
B <= x"EC1"; 
wait for 100ms;
-- E = R - B    E = 59.93750 
R <= x"000"; 
B <= x"C41"; 
wait for 100ms;
-- E = R - B    E = 99.87500 
R <= x"000"; 
B <= x"9C2"; 
wait for 100ms;
-- E = R - B    E = 59.93750 
R <= x"000"; 
B <= x"C41"; 
wait for 100ms;
-- E = R - B    E = 19.93750 
R <= x"000"; 
B <= x"EC1"; 
wait for 100ms;
-- E = R - B    E = -20.06250 
R <= x"000"; 
B <= x"141"; 
wait for 100ms;
-- E = R - B    E = -60.000 
R <= x"000"; 
B <= x"3C0"; 
wait for 100ms;
-- E = R - B    E = -100.0  
R <= x"000"; 
B <= x"640"; 
wait for 100ms;

end process;

end Behavioral;
