----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.05.2023 11:24:20
-- Design Name: 
-- Module Name: muxJmp - Behavioral
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

entity muxJmp is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           Qa : in STD_LOGIC_VECTOR (7 downto 0);
           Qb : in STD_LOGIC_VECTOR (7 downto 0);
           s : out STD_LOGIC;
           JmpTo : out STD_LOGIC_VECTOR (7 downto 0));
end muxJmp;

architecture Behavioral of muxJmp is

begin
    s<='1' when OP=x"0F" and QA=x"00" else '0'; 
    

end Behavioral;
