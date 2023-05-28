----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 12:51:29
-- Design Name: 
-- Module Name: mux_outMB - Behavioral
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

entity mux_outMB is
    Port ( OUTmb : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           OP : in STD_LOGIC_VECTOR (3 downto 0);
           out_mux : out STD_LOGIC_VECTOR (7 downto 0));
end mux_outMB;

architecture Behavioral of mux_outMB is
begin 
multiplex_out_mb: process (OUTmb,OP,B) is 
begin
if (OP=x"7") then
    out_mux <= outmb;
else
    out_mux<=B;
end if;

end process;

end Behavioral;
