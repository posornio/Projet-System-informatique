----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 13:16:30
-- Design Name: 
-- Module Name: LC_MB - Behavioral
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

entity LC_MB is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           s : out STD_LOGIC);
           --s met a 1 le bit de lecture
end LC_MB;

architecture Behavioral of LC_MB is

begin
lcmb : process (OP) is 
begin
if (OP=x"08") then 
    s<='0';
else
   s<='1';
   
end if;

end process;



end Behavioral;
