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

entity testMB is
--  Port ( );
end testMB;

architecture Behavioral of testMB is 
component Membank port (
             at : in STD_LOGIC_VECTOR (7 downto 0);
           INmb : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTmb : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal at: std_logic_vector(7 downto 0):=x"01";
signal INmb:  std_logic_vector(7 downto 0):=x"01";
signal RW: std_logic:='0';
signal RST: std_logic:='0';
signal CLk: std_logic:='1';
signal OUTmb: std_logic_vector(7 downto 0);
    constant Clock_period :time:=1Ns;

begin
MBtest: MemBank port map(
at=>at,
INmb=>INmb,
RW=>RW,
RST=>RST,
CLK=>CLK,
OUTmb=>OUTmb);

clkProcess :process
 begin 
    clk <= not(clk);
    wait for Clock_period/2;
 end process;
    RW <= '1' after 2 ns, '0' after 5 ns, '1' AFTER 10 ns;
      at<= x"11" after 10 ns, x"01" after 20 ns,  x"01" after 25 ns;
      inMB<= x"10" after 10 ns;
end ;
