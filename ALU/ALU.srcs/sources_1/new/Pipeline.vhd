----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 10:36:17
-- Design Name: 
-- Module Name: Pipeline - Behavioral
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

entity Pipeline is
Port(
 CLK : in STD_LOGIC;
 RST : in STD_LOGIC;
 B: out STD_LOGIC_VECTOR (7 downto 0)

 );
 
 
--  Port ( );
end Pipeline;


architecture Behavioral of Pipeline is

component MemInst is
    Port ( at : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           outInst : out STD_LOGIC_VECTOR (31 downto 0));
end component;
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
  component Membank port (
               at : in STD_LOGIC_VECTOR (7 downto 0);
             INmb : in STD_LOGIC_VECTOR (7 downto 0);
             RW : in STD_LOGIC;
             RST : in STD_LOGIC;
             CLK : in STD_LOGIC;
             OUTmb : out STD_LOGIC_VECTOR (7 downto 0));
  end component;
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

 signal lidi_a : STD_LOGIC_VECTOR (7 downto 0);
 signal lidi_b :  STD_LOGIC_VECTOR (7 downto 0);
 signal lidi_c :  STD_LOGIC_VECTOR (7 downto 0);
 signal lidi_op :  STD_LOGIC_VECTOR (7 downto 0);
 
 
signal diex_a:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_b:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_c:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_op:  STD_LOGIC_VECTOR (7 downto 0);
 
 signal ex_mem_a:  STD_LOGIC_VECTOR (7 downto 0);
signal  ex_mem_b:  STD_LOGIC_VECTOR (7 downto 0);
 signal ex_mem_c:  STD_LOGIC_VECTOR (7 downto 0);
signal ex_mem_op:  STD_LOGIC_VECTOR (7 downto 0);


signal mem_re_a:  STD_LOGIC_VECTOR (7 downto 0);
signal mem_re_b:  STD_LOGIC_VECTOR (7 downto 0);
signal mem_re_c:  STD_LOGIC_VECTOR (7 downto 0);
signal mem_re_op: STD_LOGIC_VECTOR (7 downto 0); 

signal a_MI: std_logic_vector(7 downto 0);

signal qa2mux1:std_logic_vector(7 downto 0);
signal mux1:std_logic_vector(7 downto 0);
signal mux2: std_logic_vector(7 downto 0);

signal OutMb2mux3: STD_LOGIC_VECTOR (7 downto 0) ;
signal mux3: std_logic_vector(7 downto 0);

signal lc1: std_logic_vector(7 downto 0);
signal lc2: std_logic;
signal w2lc3: std_logic;
signal lc3: std_logic_vector(7 downto 0);

signal S_Alu: std_logic_vector(7 downto 0);


begin


instbank: MemInst port map(
    at=>a_MI,
    CLK=>CLK,
    OUTinst(7 downto 0) =>lidi_a,
    OUTinst(15 downto 7) =>lidi_op,
    OUTinst(23 downto 15) =>lidi_b,
    OUTinst(31 downto 23) =>lidi_c
    );

 RegisBank: RegBank port map(
      atA=>lidi_b,
     atB=>lidi_c,
     atW=>mem_re_a,
     W=>w2lc3,
     DATA=>mem_re_b,
     RST=>RST,
     CLK=>CLK,
     QA=>mux1,
     QB=>diex_c    
 );
 ALUpip: ALU PORT MAP(
        A=>diex_b,
        B =>diex_c,
        S=>S_Alu,
        Ctrl_Alu=>lc1
        );
        
  MB: MemBank port map(
        at=>mux2,
        INmb=>ex_mem_b,
        RW=>lc2,
        RST=>RST,
        CLK=>CLK,
        OUTmb=>OutMb2mux3);

process
begin 
    wait until CLK'event and CLK='1';
    diex_a <= lidi_a;
    diex_op <= lidi_op;
    ex_mem_a <= diex_a;
    ex_mem_op <= diex_op;
    mem_re_a <= ex_mem_a;
    mem_re_op <= mem_re_op;
    mux1<=lidi_b when (lidi_op=x"06") else "00", -- faire logique mux1;
    
    if (lidi_op = x"06") then 
        diex_b <=mux1;
        ex_mem_b <= diex_b;
        mem_re_b <=ex_mem_b ;
    else 
        
    end if;
    


end process;
end Behavioral;
