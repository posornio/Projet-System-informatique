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
           alea: in STD_LOGIC;
           outInst : out STD_LOGIC_VECTOR (31 downto 0));
end MemInst;

architecture Behavioral of MemInst is

type inst_bank is array(0 to 255) of  STD_LOGIC_VECTOR (31 downto 0);

type inst_bank_aux is array(127 downto 0) of  STD_LOGIC_VECTOR (31 downto 0);
signal my_bankAUX1: inst_bank_aux:=(others=>(x"01061200"));
 signal my_bankAUX2: inst_bank_aux:=(others=>(x"02050100"));


signal my_bank: inst_bank:= (x"01060C00",x"02050100", others=>(x"11111111")) ;

begin
process
begin
   -- for i in 0 to 7 loop 
     --my_bank(i) <=  std_logic_vector(to_unsigned(i, my_bank'length));
     --end loop; 

    wait until CLK'event and CLK='1';
     if alea='1' then 
        outInst <= x"00000000";
     else
     outInst <= my_bank(to_integer(unsigned(at)));
end if;
end process;



end Behavioral;
