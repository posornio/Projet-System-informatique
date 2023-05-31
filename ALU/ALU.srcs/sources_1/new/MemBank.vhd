----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 09:11:42
-- Design Name: 
-- Module Name: MemBank - Behavioral
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

entity MemBank is
    Port ( at : in STD_LOGIC_VECTOR (7 downto 0);
           INmb : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTmb : out STD_LOGIC_VECTOR (7 downto 0) );
end MemBank;

architecture Behavioral of MemBank is
type mem_bank is array(0 to 255) of  STD_LOGIC_VECTOR (7 downto 0);
signal my_bank: mem_bank:= (others=>(x"42")) ;
    
    begin
process
begin
     --for i in 0 to 7 loop 
       -- my_bank(i) <=  std_logic_vector(to_unsigned(i, my_bank'length));
     --end loop; 
    wait until CLK'event and CLK='1';
    if (RST='1') then 
        my_bank <= (others => (others => '0'));
    else
        if (RW='1') then
            outMB <= my_bank(to_integer(unsigned(at)));
        else
            outMB <= (others => '0');
            my_bank(to_integer(unsigned(at))) <= INmb;
         end if;
 end if;

end process;

end Behavioral;
