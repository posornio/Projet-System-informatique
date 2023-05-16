----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 09:13:09
-- Design Name: 
-- Module Name: MemInst - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MemInst is
    Port ( at : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           outInst : out STD_LOGIC_VECTOR (31 downto 0));
end MemInst;

architecture Behavioral of MemInst is

type mem_bank is array(7 downto 0) of  STD_LOGIC_VECTOR (31 downto 0);
signal my_bank: mem_bank:=(others => (others => '0')) ;
begin
process
begin
    wait until CLK'event and CLK='1';
   outInst <= my_bank(to_integer(unsigned(at)));

end process;



end Behavioral;
