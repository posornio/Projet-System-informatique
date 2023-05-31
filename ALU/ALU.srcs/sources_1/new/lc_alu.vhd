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
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0));
end lc_alu;

architecture Behavioral of lc_alu is


begin
lcmr : process (OP) is 
begin
case OP is
          when x"01" => s<="0001";
          when x"02" => s<="0010";
          when x"03" => s <= "0011";
          when x"0A" => s<="0100";
          --a<b0
          when x"0B" => s<="0101";
          --a<=b
          when x"0C" => s <= "0110";
          --a>b 
          when x"0D" => s <= "0111";
          --a>=b
          when x"12" => s<="1000";
          --a==b
          when x"13" => s<="1001";
          --a!=b
          when others => s <= "0000" ;
  end case;
end process;


end Behavioral;
