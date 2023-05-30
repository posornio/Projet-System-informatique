----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2023 13:23:42
-- Design Name: 
-- Module Name: GestAleas - Behavioral
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

entity GestAleas is
    Port ( op_lidi : in STD_LOGIC_VECTOR (7 downto 0);
           b_lidi : in STD_LOGIC_VECTOR (7 downto 0);
           c_lidi : in STD_LOGIC_VECTOR (7 downto 0);
           op_diex : in STD_LOGIC_VECTOR (7 downto 0);
           a_diex : in STD_LOGIC_VECTOR (7 downto 0);
           op_em : in STD_LOGIC_VECTOR (7 downto 0);
           a_em : in STD_LOGIC_VECTOR (7 downto 0);
           
           s : out STD_LOGIC);
end GestAleas;

architecture Behavioral of GestAleas is
signal r_li: std_logic:='0';
signal w_di: std_logic:='0';
signal w_ex: std_logic:='0';
signal alea_di: std_logic:='0';
signal alea_ex: std_logic:='0';
    
    begin
    
    r_li <= '1' when op_lidi = x"01"  or op_lidi=x"02"  or op_lidi=x"03"  
    or op_lidi=x"04"  or op_lidi=x"05"  or op_lidi=x"08"  or op_lidi=x"09"
    else '0';   
    
    w_di <='1' when op_diex = x"06" or op_diex=x"07" else '0';
    w_ex <='1' when op_em=x"06" or op_em=x"07" else '0'; 
    
    alea_di <= '1' when r_li='1' and w_di='1' and (b_lidi = a_diex or c_lidi = a_diex) else '0';
    alea_ex <='1' when r_li='1' and w_ex='1' and (b_lidi = a_em or c_lidi = a_em) else '0';

    s <= '1' when alea_di ='1' or alea_ex='1'
     else '0';
end Behavioral;
