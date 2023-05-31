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
    Port (Inst_LIDI:  in STD_LOGIC_VECTOR (31 downto 0);
           op_diex : in STD_LOGIC_VECTOR (7 downto 0);
           a_diex : in STD_LOGIC_VECTOR (7 downto 0);
           op_em : in STD_LOGIC_VECTOR (7 downto 0);
           a_em : in STD_LOGIC_VECTOR (7 downto 0);
           op_memre : in STD_LOGIC_VECTOR (7 downto 0);
           QA: in STD_logic_vector(7 downto 0);
           QB: in STD_logic_vector(7 downto 0);
           s : out STD_LOGIC;
           jmpBit: out std_logic;
           jumpTo: out std_logic_vector( 7 downto 0);
           outInst: out  STD_LOGIC_VECTOR (31 downto 0)
           );
end GestAleas;

architecture Behavioral of GestAleas is
signal r_li: std_logic:='0';
signal w_di: std_logic:='0';
signal w_ex: std_logic:='0';
signal jmpAux: std_logic:='0';

signal alea_di: std_logic:='0';
signal alea_ex: std_logic:='0';
signal a_lidi: STD_LOGIC_VECTOR (7 downto 0);  
    
signal op_lidi: STD_LOGIC_VECTOR (7 downto 0);  
signal b_lidi: STD_LOGIC_VECTOR (7 downto 0) ;
signal c_lidi: STD_LOGIC_VECTOR (7 downto 0) ;


    begin
    a_lidi<=Inst_LIDI(31 downto 24);
    op_lidi<=Inst_LIDI(23 downto 16);
    b_lidi<=Inst_LIDI(15 downto 8);   
    c_lidi<=Inst_LIDI(7 downto 0);  
            
    r_li <= '1' when op_lidi = x"01"  or op_lidi=x"02"  or op_lidi=x"03" OR op_lidi=x"0F"  
    or op_lidi=x"04"  or op_lidi=x"05"  or op_lidi=x"08"  or op_lidi=x"09"
    or op_lidi=x"10" or op_lidi=x"11"
    else '0';   
    
    w_di <='1' when op_diex = x"06" or op_diex=x"07" else '0';
    w_ex <='1' when op_em=x"06" or op_em=x"07" else '0'; 
    --JMP : 0E, JMPF : 0f   JEQ: 10 JNE: 11
    alea_di <= '1' when r_li='1' and w_di='1' and (b_lidi = a_diex or c_lidi = a_diex) else '0';
    alea_ex <='1' when r_li='1' and w_ex='1' and (b_lidi = a_em or c_lidi = a_em) else '0';
    jmpBit<='1' when ((op_diex=x"0E") or (op_memre=x"0F" and QA=x"00") 
    or (op_memre=x"10" and QA=QB) or (op_memre=x"11" and QA/=QB)) else '0';
    jmpAux<='1' when ((op_diex=x"0E") or (op_em=x"0F") or (op_memre=x"0F") or (op_diex=x"0F") 
        or (op_diex=x"10" ) or (op_diex=x"11")) else '0';
    jumpTo<=a_lidi when op_memre=x"0E" or op_lidi=x"0F" or (op_memre=x"10" ) or (op_memre=x"11") ;
    s <= '1' when alea_di ='1' or alea_ex='1' or jmpAux='1'
     else '0';
     
     Outinst <= x"00000000" when alea_di ='1' or alea_ex='1' or jmpAux='1'
          else Inst_LIDI;
    
end Behavioral;
