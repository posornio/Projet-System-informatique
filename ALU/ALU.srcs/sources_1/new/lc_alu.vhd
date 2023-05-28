----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 13:15:47
-- Design Name: 
-- Module Name: lc_alu - Behavioral
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

entity lc_alu is
    Port ( OP : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0));
end lc_alu;

architecture Behavioral of lc_alu is


begin
lcmr : process (OP) is 
begin
case OP is
          when x"1" => s<="001";
          when x"2" => s<="010";
          when x"3" => s <= "011";
          when x"A" => s<="100";
          when x"B" => s<="101";
          when x"C" => s <= "110";
          when x"D" => s <= "111";
          when others => s <= "000" ;
  end case;
end process;


end Behavioral;
