----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2023 12:25:51
-- Design Name: 
-- Module Name: testCount - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testCount is
--  Port ( );
end testCount;



architecture Behavioral of testCount is
component counter is
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PAUSE : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end component;
signal RST: std_logic :='0';
signal PAUSE: std_logic :='0';
signal clkTest : STD_LOGIC :='1';
signal CLK: std_logic :='1';
signal S :  STD_LOGIC_VECTOR (7 downto 0);

constant Clock_period :time:=10ns;

begin

counterC: counter port map(
    RST=>RST,
    CLK=>CLK,
    PAUSE=>PAUSE,
    S=>S
);
clkProcess :process
 begin 
    clk <= not(clk);
    wait for Clock_period/2;
 end process;
 
 PAUSE <= '0' after 10 ns, '1' after 20 ns , '0' after 60 ns; 

end Behavioral;
