----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 12:35:12
-- Design Name: 
-- Module Name: muxIN_MB - Behavioral
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

entity muxIN_MB is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           OP : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           mux_out : out STD_LOGIC_VECTOR (7 downto 0));
end muxIN_MB;

architecture Behavioral of muxIN_MB is

begin
multiplex_in_mb : process (A,OP,B) is 
begin
if (OP=x"8") then 
    mux_out<= A;
else
   mux_out<=B;
   
end if;

end process;

end Behavioral;
