----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 15:01:32
-- Design Name: 
-- Module Name: test_ALU - Behavioral
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

entity test_ALU is
--  Port ( );
end test_ALU;

architecture Behavioral of test_ALU is
    COMPONENT ALU
    PORT(      A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               N : out STD_LOGIC;
               O : out STD_LOGIC;
               Z : out STD_LOGIC;
               C : out STD_LOGIC;
               S : out STD_LOGIC_VECTOR (7 downto 0);
               Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0));
   END COMPONENT;

   signal A,B: std_logic_vector(7 downto 0):="11100000";
  -- signal ControlTest: std_logic_vector(2 downto 0):=(others=>'0');
   signal Ctrl_Alu: std_logic_vector(2 downto 0):="001";
   signal S:std_logic_vector(7 downto 0):=(others=>'0');
   signal N, O, Z,C:STD_LOGIC;
   signal clkTest : STD_LOGIC :='1';
   constant Clock_period :time:=10ns;

begin
    UUTtest: ALU PORT MAP(
        A=>A,
        B =>B,
        N=> N,
        O=> O,
        Z=>Z,
        C=>C,
        S=>S,
        Ctrl_Alu=>Ctrl_Alu
        );
 clkProcess :process
 begin 
    clkTest <= not(clkTest);
    wait for Clock_period/2;
 end process;
 
 A <= "00110011" after 10 ns, "11111111" after 20 ns,  "01010101" after 25 ns;
 B <= "00001111" after 10 ns,"00001111" after 20 ns , "00000111" after 28 ns;
 Ctrl_Alu <= "001" after 10 ns, "100" after 20 ns, "010" after 24 ns;
    


end;
