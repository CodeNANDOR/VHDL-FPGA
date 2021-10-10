library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_starter is
end tb_starter;

architecture Behavioral of tb_starter is

component starter 
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           stop : in STD_LOGIC;
           run : in STD_LOGIC;
           ena_pid : out STD_LOGIC;
           LAMP : out STD_LOGIC_VECTOR (1 downto 0));
end component;


signal clk,reset,stop,run,ena_pid:std_logic:='0';
signal LAMP:std_logic_vector(1 downto 0):=(others => '0');

begin

tb_starter : starter
port map(
         clk => clk,
         reset => reset,
         stop => stop,
         run => run,
         ena_pid => ena_pid,
         LAMP => LAMP
         ); 
         
clk_simu:process    
begin
    clk <= '0';
    wait for 5ns;
    clk <= '1';
    wait for 5ns;
end process clk_simu; 
  
run_simu:process
begin
    run <= '0';
    wait for 50ns;
    run <= '1';
    wait for 10ns;
    run <= '0';
    wait for 50ms;
end process run_simu;

circuito_simu:process
begin
    reset <= '0'; stop <= '0';
           wait for 20ms;
           
    reset <= '0'; stop <= '1';
           wait for 10ns;
    reset <= '0'; stop <= '0';
           wait for 20ms;
           
    reset <= '1'; stop <= '0';
           wait for 10ns;
    reset <= '0'; stop <= '0';
           wait for 20ms;
                  
end process circuito_simu;

end Behavioral;
