----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2023 11:11:09
-- Design Name: 
-- Module Name: RegBank - Behavioral
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

entity RegBank is
    Port ( atA : in STD_LOGIC_VECTOR (3 downto 0);
           atB : in STD_LOGIC_VECTOR (3 downto 0);
           atW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           op : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end RegBank;

architecture Behavioral of RegBank is
type bank is array(0 to 15) of  STD_LOGIC_VECTOR (7 downto 0);
signal my_bank: bank:= (
    ( x"04"),(x"0E"), (x"08") , (x"0C") 
    ,(x"0B"), (x"0A") ,(x"09"),
    (x"08"), (x"07"), (x"06"),
    (x"05"), (x"77" ), (x"08"), 
    (x"08"), (x"0D"),(x"03")) ;
    
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
            if (W='1') then
                my_bank(to_integer(unsigned(atW))) <= Data;
             end if;
     end if;
    
end process;
QA <= my_bank(to_integer(unsigned(atA))) when op/=x"00";
QB <= my_bank(to_integer(unsigned(atB))) when op/=x"00";

end Behavioral;
