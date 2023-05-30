----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 10:50:49
-- Design Name: 
-- Module Name: MuxBr - Behavioral
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

entity MuxBr is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);          
           QA : in STD_LOGIC_VECTOR (7 downto 0);        
           outMux : out STD_LOGIC_VECTOR (7 downto 0));
end MuxBr;

architecture Behavioral of MuxBr is

begin 
multiplexBR : process (OP,B, QA) is
begin 
  if (OP=x"06") or (OP=x"07") then
    outMUX<=B;
  else 
  outMUX<= QA;
end if;


end process;


end Behavioral;
