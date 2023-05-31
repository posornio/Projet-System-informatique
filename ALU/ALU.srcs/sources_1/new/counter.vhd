----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2023 12:18:42
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PAUSE : in STD_LOGIC;
           jmp: in std_logic;
           jumpto: in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end counter;

architecture Behavioral of counter is
signal sortie:std_logic_vector(7 downto 0):=x"00";
begin
process(CLK,RST) 
begin 
    if RST='1' then 
        sortie <= x"00";
    elsif rising_edge(clk) then
       if PAUSE='1' then 
            sortie<=sortie;
        if jmp='1' then sortie<=jumpto; end if;
      else 
        if jmp='0' then sortie<=sortie + x"01";
        else sortie<=jumpto;
        end if;
    end if;
    end if;
    
end process;
S<=sortie;
end Behavioral;
