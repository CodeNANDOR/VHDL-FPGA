library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_set_point is
end tb_set_point;

architecture Behavioral of tb_set_point is

component set_point 
    Port ( clk : in STD_LOGIC;
           down : in STD_LOGIC;
           up : in STD_LOGIC;
           rst : in STD_LOGIC;
           btime : in STD_LOGIC;
           ena : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (11 downto 0));
end component;


signal clk,down,up,rst,btime,ena:std_logic:='0';
signal R:std_logic_vector(11 downto 0):=(others => '0');

begin

tb_set_point : set_point
port map(
         clk => clk,
         down => down,
         up => up,
         rst => rst,
         btime => btime,
         ena => ena,
         R => R
         ); 
         
rst <= '0';
ena <= '1';

clk_simu:process    
begin
    clk <= '0';
    wait for 5ns;
    clk <= '1';
    wait for 5ns;
end process clk_simu;

btime_simu:process    
begin
    btime <= '0';
    wait for 999_990ns;
    btime <= '1';
    wait for 10ns;
end process btime_simu;
   
circuito_simu:process    --P = 250ms.
    variable i:integer:=0;
    variable up_down:std_logic:='0';
begin
    if(up_down = '0')then
     wait for 100ns;
        for i in 0 to 30-1 loop
            up <= '0';
            wait for 999_990ns;
            up <= '1';
            wait for 10ns;
            up <= '0';
        end loop;
       up_down := '1';
    else
     wait for 1000ns;
        for i in 0 to 10-1 loop
            down <= '0';
            wait for 999_990ns;
            down <= '1';
            wait for 10ns;
            down <= '0';
        end loop;
          wait for 10ms;
        	assert false -- Secuencia para términar simulación automáticamente (Creamos una falla controlada)
		    report "Simulación finalizada."
		    severity failure; -- Detenemos la simulación
    end if;
end process circuito_simu; 

end Behavioral;