----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 09:30:15
-- Design Name: 
-- Module Name: testMB - Behavioral
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

entity MI_test is
--  Port ( );
end MI_test;

architecture Behavioral of MI_test is 
component MemInst is
    Port ( at : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           alea: in STD_LOGIC:='0';
           outInst : out STD_LOGIC_VECTOR (31 downto 0));
end component;


signal at: std_logic_vector(7 downto 0):=x"00";
signal CLk: std_logic:='1';
signal alea: std_logic:='0';
signal outInst: std_logic_vector(31 downto 0);
    constant Clock_period :time:=1Ns;

begin
testMI: MemInst port map(
at=>at,
CLK=>CLK,
alea=>alea,
OUTinst=>OUTinst);

clkProcess :process
 begin 
    clk <= not(clk);
    wait for Clock_period/2;
 end process;
      at<= x"01" after 10 ns, x"02" after 20 ns,  x"03" after 25 ns;
end ;
