----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 11:44:56
-- Design Name: 
-- Module Name: etage4 - Behavioral
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

entity etage3 is
    Port ( Ain : in STD_LOGIC_VECTOR (7 downto 0);
           OPin : in STD_LOGIC_VECTOR (3 downto 0);
           Bin : in STD_LOGIC_VECTOR (7 downto 0);
           Aout : out STD_LOGIC_VECTOR (7 downto 0);
           Bout : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OPout : out STD_LOGIC_VECTOR (3 downto 0));
end etage3;

architecture Behavioral of etage3 is
begin
process
begin
    wait until CLK'event and CLK='1';
    Aout<=Ain;
    Bout<=Bin;
    OPout<=OPin;

end process;

end Behavioral;
