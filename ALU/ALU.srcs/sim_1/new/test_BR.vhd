----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2023 12:09:48
-- Design Name: 
-- Module Name: test_BR - Behavioral
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

entity test_BR is
--  Port ( );
end test_BR;

architecture Behavioral of test_BR is
    Component regBank port(
               atA : in STD_LOGIC_VECTOR (3 downto 0);
               atB : in STD_LOGIC_VECTOR (3 downto 0);
               atW : in STD_LOGIC_VECTOR (3 downto 0);
               W : in STD_LOGIC;
               DATA : in STD_LOGIC_VECTOR (7 downto 0);
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               QA : out STD_LOGIC_VECTOR (7 downto 0);
               QB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal atA: std_logic_vector(3 downto 0):="0100";
    signal atB: std_logic_vector(3 downto 0):="0011";
    signal atW: std_logic_vector(3 downto 0) :="0100";
    signal W: std_logic :='0';
    signal RST: std_logic :='0';
    signal CLK: std_logic :='1';
    signal QA,QB :  STD_LOGIC_VECTOR (7 downto 0);
        signal DATA :  STD_LOGIC_VECTOR (7 downto 0):=x"01";

    constant Clock_period :time:=1Ns;
        
begin

BRtest: RegBank PORT MAP(
    atA=>atA,
    atB=>atB,
    atW=>atW,
    W=>W,
    DATA=>DATA,
    RST=>RST,
    CLK=>CLK,
    QA=>QA,
    QB=>QB    
);
clkProcess :process
 begin 
    clk <= not(clk);
    wait for Clock_period/2;
 end process;
    W <= '1' after 2 ns, '0' after 5 ns, '1' AFTER 10 ns;
    atW <= "0011" after 12 ns;
    DATA<= x"1F" after 9ns, x"20" after 18 ns;
  atA <= "0011" after 10 ns, "0111" after 20 ns,  "0101" after 25 ns;
 atB <= "0111" after 10 ns,X"07" after 20 ns , "0010" after 28 ns;
 

end ;
