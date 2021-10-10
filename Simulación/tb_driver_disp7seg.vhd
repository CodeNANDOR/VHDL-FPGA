library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_driver_disp7seg is
end tb_driver_disp7seg;

architecture Behavioral of tb_driver_disp7seg is

component driver_disp7seg 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           btime : in STD_LOGIC;
           ena : in STD_LOGIC;
           DD_0 : in STD_LOGIC_VECTOR (3 downto 0);
           DD_1 : in STD_LOGIC_VECTOR (3 downto 0);
           DD_2 : in STD_LOGIC_VECTOR (3 downto 0);
           DD_3 : in STD_LOGIC_VECTOR (3 downto 0);
           DD_4 : in STD_LOGIC_VECTOR (3 downto 0);
           DD_5 : in STD_LOGIC_VECTOR (3 downto 0);
           DD_6 : in STD_LOGIC_VECTOR (3 downto 0);
           DD_7 : in STD_LOGIC_VECTOR (3 downto 0);
           SEG7 : out STD_LOGIC_VECTOR (7 downto 0);
           DISP : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk,rst,btime,ena:std_logic:='0';
signal DD_7,DD_6,DD_5,DD_4,DD_3,DD_2,DD_1,DD_0:std_logic_vector(3 downto 0):=(others => '0');
signal SEG7,DISP:std_logic_vector(7 downto 0):=(others => '0');

begin

tb_driver_disp7seg : driver_disp7seg
port map(
           clk   => clk,
           rst   => rst,
           btime => btime,
           ena   => ena,
           DD_0  => DD_0,----
           DD_1  => DD_1,------* Temperatura medida por el sensor: 
           DD_2  => DD_2,------* (B)
           DD_3  => DD_3,----
           DD_4  => DD_4,----
           DD_5  => DD_5,------* Temperatura requerida por el sistema: 
           DD_6  => DD_6,------* (R)
           DD_7  => DD_7,----
           SEG7  => SEG7,
           DISP  => DISP
         );   
         
rst <= '0';
ena <= '1';   

DD_0 <= x"7";
DD_1 <= x"4";                                   
DD_2 <= x"1";                                        
DD_3 <= x"3";          
DD_4 <= x"9";          --SET POINT (°C)      TEMP (°C)
DD_5 <= x"6";             --52.69              31.47
DD_6 <= x"2";
DD_7 <= x"5";  

clk_simu:process    
begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
end process clk_simu;     

btime_simu:process   --2ms.
begin
        btime <= '0';
        wait for 1_999_990 ns;      
        btime <= '1';
        wait for 10 ns;
end process btime_simu;        

end Behavioral;