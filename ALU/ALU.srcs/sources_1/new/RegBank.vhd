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
           OP : in STD_LOGIC_VECTOR (7 downto 0);

           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end RegBank;

architecture Behavioral of RegBank is
type bank is array(0 to 15) of  STD_LOGIC_VECTOR (7 downto 0);
signal my_bank: bank:= (
    others=>(others=>'0')) ;
    signal auxa :std_logic_vector (7 downto 0) :=x"00";
        signal auxb :std_logic_vector (7 downto 0) :=x"00";
        signal s :std_logic_vector (7 downto 0) :=x"00";

    
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
                
            else 
                if OP/=x"00" then
                auxa<=my_bank(to_integer(unsigned(atA)));
                auxB <=my_bank(to_integer(unsigned(atB)));
                end if;
             end if;
     end if;
    
end process;
QA <= my_bank(to_integer(unsigned(atA))) when w='0' or Ata/=atW  else DATA ;
QB <= my_bank(to_integer(unsigned(atB))) when w='0' or AtB/=atW  else DATA;

end Behavioral;