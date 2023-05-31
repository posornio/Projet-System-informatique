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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


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


--signal my_bank: inst_bank:= (x"01010101",x"01010101",x"01010101",x"03060000",x"02060000",x"020E0203",x"04041200", x"07071200",x"08081200",x"00000000",
  -- x"020F0500" ,others=>(x"11221111")) ;
--signal my_bank: inst_bank:= (x"07060500",x"03050700",x"08050000",x"02050800",x"00000000",x"09050300",x"08060000",x"090C0908",x"09001000",x"07050200",x"08050000",x"09060400",x"08020809",x"07010708",x"02050700",x"040E0000",x"07050200",x"07050000",x"08060300",x"07030708",x"07060100",x"07000000",x"07060000",x"1e0E1b00",x"07050000",x"07000000",x"07060400",x"01050700",x"08050100",x"08000000",others=>(x"00000000"));
signal my_bank: inst_bank := (x"00000000",x"01060500",x"02060700",x"04060700",x"01010204",x"05120204",others=>(x"00000000"));
   -- for i in 0 to 7 loop 
     --my_bank(i) <=  std_logic_vector(to_unsigned(i, my_bank'length));
     --end loop; 
begin
    
        OUTINST<=my_bank(to_integer(unsigned(at)));



end Behavioral;
