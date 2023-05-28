----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 12:28:29
-- Design Name: 
-- Module Name: muxALU - Behavioral
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

entity muxALU is
    Port ( OP : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S_ALU : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end muxALU;

architecture Behavioral of muxALU is


begin 
multiplexALU : process (OP,B, S_ALU) is
begin 
  if ( OP > x"0" and OP < x"4") or ( OP > x"9" and OP < x"E") then
    S <= S_alu; --ADD, MUL, SOU
   else 
    S<= B;
end if;


end process;



end Behavioral;
