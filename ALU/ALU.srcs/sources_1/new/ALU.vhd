----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 10:40:44
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
process (A,B,Ctrl_ALU)
    variable tempR :std_logic_vector(8 downto 0);
    variable tempRMul :std_logic_vector(15 downto 0);

    variable carry :std_logic;
    variable overflow :std_logic;
    begin 
        tempR := (others => '0');
        tempRMul := (others => '0');

        carry := '0';
        overflow:='0';
    
        case  (Ctrl_Alu) is
            when "001" => --somme
                tempR := ('0' & A) + ('0' & B);
                carry := tempR(8);
                overflow := (A(7) xor B(7)) and (A(7) xor tempR(7)); 
            when "011" => --soustraction 
               tempR := ('0' & A) - ('0' & B);
               carry := not tempR(8);
               overflow := (A(7) xor B(7)) and (A(7) xor tempR(7));
            when "010" => --multiplication
                tempRMul := A*B;
                tempR := tempRMul(8 downto 0);
                if (tempRMul(15 downto 8) /= "00000000") then
                    overflow := '1';
                 else 
                    overflow :='0';
                    end if; 
            when "100" => --a<b
                if (a<b) then 
                tempR:= '0'& x"01";
                else 
                 tempR:='0'& x"00";
                 end if;
            when "101" => --a>b
                if (a<b) then 
                    tempR:='0'& x"01";
                else 
                   tempR:='0'& x"00";
                end if;
           when "110" => --a==b   
             if (a=b) then 
                tempR:='0'& x"01";
             else 
                tempR:='0'& x"00";
             end if;
            when "111" => --a==b   
            if (a/=b) then 
                tempR:='0'& x"01";
            else 
                tempR:='0'& x"00";
            end if;             
           when others =>
            tempR := (others=> '0');
       end case;
       S <= tempR(7 downto 0);
       if (tempR = x"00") then 
            Z<='1';
       else 
            Z<='0';
       end if;   
       C <= carry;
       O <= overflow;
end process;
end architecture Behavioral;
