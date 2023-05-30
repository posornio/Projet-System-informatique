----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2023 15:25:52
-- Design Name: 
-- Module Name: testPipe - Behavioral
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

entity testPipe is
--  Port ( );
end testPipe;

architecture Behavioral of testPipe is
component Pipeline is port( CLK : in STD_LOGIC;
RST : in STD_LOGIC;
S :out std_logic_vector(7 downto 0) );
end component;
signal rst: std_logic;
signal clk: std_logic :='0';
signal b: std_logic_vector(7 downto 0);
constant clock_period :time:= 10 ns;
begin
pipe : Pipeline port map(
rst=>rst,
clk=>clk,
S=>B);
      
clkProcess :process
       begin 
          clk <= not(clk);
          wait for Clock_period/2;
end process;


--Test somme 1 2




end ;