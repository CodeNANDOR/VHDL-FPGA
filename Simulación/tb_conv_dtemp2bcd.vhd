
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_conv_dtemp2bcd is
end tb_conv_dtemp2bcd;

architecture Behavioral of tb_conv_dtemp2bcd is

component conv_dtemp2bcd 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           ena : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (11 downto 0);
           I1 : out STD_LOGIC_VECTOR (3 downto 0);    
           I0 : out STD_LOGIC_VECTOR (3 downto 0);   
           F1 : out STD_LOGIC_VECTOR (3 downto 0);   
           F0 : out STD_LOGIC_VECTOR (3 downto 0));  
end component;

signal clk,rst,start,ena:std_logic:='0';
signal DATA:STD_LOGIC_VECTOR (11 downto 0):=(others => '0');
signal I1,I0,F1,F0:STD_LOGIC_VECTOR (3 downto 0):=(others => '0');

begin

tb_conv_dtemp2bcd : conv_dtemp2bcd   
port map(
         clk => clk,
         rst => rst,
         start => start,
         ena => ena,
         DATA => DATA,
         I1 => I1,                
         I0 => I0,                
         F1 => F1,                
         F0 => F0                 
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

start_simu:process    
begin
    start <= '0';
    wait for 249_999_990ns;
    start <= '1';
    wait for 10ns;
end process start_simu;   

DATA_simu:process --Formato [8.4] 
begin
    DATA <= x"0A2";     -- 10.1250 -> 0000 1010 . 0010
    wait for 250ms;
    DATA <= x"217";     -- 33.4375 -> 0010 0001 . 0111
    wait for 250ms;
end process DATA_simu;  
         

end Behavioral;