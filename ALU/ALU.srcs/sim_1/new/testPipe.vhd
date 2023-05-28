----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2023 15:25:52
-- Design Name: 
-- Module Name: testPipe - Behavioral
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

entity testPipe is
--  Port ( );
end testPipe;

architecture Behavioral of testPipe is

Component etage4 port( Ain : in STD_LOGIC_VECTOR (7 downto 0);
                 OPin : in STD_LOGIC_VECTOR (3 downto 0);
                 Bin : in STD_LOGIC_VECTOR (7 downto 0);
                 Cin : in STD_LOGIC_VECTOR (7 downto 0);
                 Aout : out STD_LOGIC_VECTOR (7 downto 0);
                 Bout : out STD_LOGIC_VECTOR (7 downto 0);
                 CLK : in STD_LOGIC;
                 Cout : out STD_LOGIC_VECTOR (7 downto 0);
                 OPout : out STD_LOGIC_VECTOR (3 downto 0));
                 end component;

component MuxBr is
    Port ( OP : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);          
           QA : in STD_LOGIC_VECTOR (7 downto 0);
           outMux : out STD_LOGIC_VECTOR (7 downto 0));
end component;

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

--signal atAbr: STD_LOGIC_VECTOR (3 downto 0);
--signal atBbr: STD_LOGIC_VECTOR (3 downto 0);
--signal atWbr: STD_LOGIC_VECTOR (3 downto 0);


 signal mi2lidi_a : STD_LOGIC_VECTOR (7 downto 0);
 signal mi2lidi_b :  STD_LOGIC_VECTOR (7 downto 0);
 signal mi2lidi_c :  STD_LOGIC_VECTOR (7 downto 0);
 signal mi2lidi_op :  STD_LOGIC_VECTOR (3 downto 0);
 
 
  signal lidi_a2diex : STD_LOGIC_VECTOR (7 downto 0);
  signal lidi_b2diex :  STD_LOGIC_VECTOR (7 downto 0);
  signal lidi_c2diex :  STD_LOGIC_VECTOR (7 downto 0);
  signal lidi_op2diex :  STD_LOGIC_VECTOR (3 downto 0);
 
 
signal diex_a:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_b:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_c:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_op:  STD_LOGIC_VECTOR (3 downto 0);
 
 signal ex_mem_a:  STD_LOGIC_VECTOR (7 downto 0);
signal  ex_mem_b:  STD_LOGIC_VECTOR (7 downto 0);
 signal ex_mem_c:  STD_LOGIC_VECTOR (7 downto 0);
signal ex_mem_op:  STD_LOGIC_VECTOR (3 downto 0);


signal mem_re_a:  STD_LOGIC_VECTOR (7 downto 0);
signal mem_re_b:  STD_LOGIC_VECTOR (7 downto 0);
signal mem_re_c:  STD_LOGIC_VECTOR (7 downto 0);
signal mem_re_op: STD_LOGIC_VECTOR (3 downto 0); 

signal a_MI: std_logic_vector(7 downto 0);

signal qa2mux1:std_logic_vector(7 downto 0);
signal muxBRsig:std_logic_vector(7 downto 0);
signal muxALU: std_logic_vector(7 downto 0);
signal signalTEST: std_logic_vector(7 downto 0);

signal muxatMB: std_logic_vector(7 downto 0);
signal mux_outMB: std_logic_vector(7 downto 0);

signal OutMb2mux4: STD_LOGIC_VECTOR (7 downto 0) ;



signal lc_ALU: std_logic_vector(2 downto 0);
signal lc_rw_mb: std_logic :='0';
signal lc_wBR: std_logic;

signal MBin:std_logic_vector(7 downto 0);

signal S_Alu: std_logic_vector(7 downto 0);


 

signal CLk: std_logic:='1';
signal RST: std_logic:='0';
constant Clock_period :time:=1Ns;

signal OutInst: std_logic_vector(31 downto 0) :=x"00000000";


begin

RegisBank: RegBank port map(
     atA=>lidi_b2diex(3 downto 0),
     atB=>lidi_c2diex (3 downto 0),
     atW=>mem_re_a(3 downto 0),
     W=>lc_wBR,
     DATA=>mem_re_b,
     RST=>RST,
     CLK=>CLK,
     QA=>qa2mux1,
     QB=>diex_c    
 );
 ALUpip: ALU PORT MAP(
        A=>diex_b,
        B =>diex_c,
        S=>S_Alu,
        Ctrl_Alu=>lc_ALU

        );
        
  MB: MemBank port map(
        at=>muxAtMB,
        INmb=>MBin,
        RW=>lc_rw_mb,
        RST=>RST,
        CLK=>CLK,
        OUTmb=>OutMb2mux4);
        
        
  LIDI: etage4 port map(
    Ain => mi2lidi_a,      
    OPin => mi2lidi_op,
    Bin => mi2lidi_b, 
    Cin => mi2lidi_c,
    Aout=> lidi_a2diex,
    OPout => lidi_op2diex,
    Bout => lidi_b2diex,
    CLK => CLK,
    Cout =>lidi_c2diex);
        
  MuxbrC: MuxBR port map(  
    OP=>lidi_op2diex,
    B=>lidi_b2diex,
    QA=>qa2mux1,
    outMux => diex_b);
      
clkProcess :process
       begin 
          clk <= not(clk);
          wait for Clock_period/2;
end process;

mi2lidi_a<=OutInst(7 downto 0);
mi2lidi_op <=OUTinst(11 downto 8);
mi2lidi_b <=OUTinst(23 downto 16);
mi2lidi_c <= OUTinst(31 downto 24);

--Test somme 1 2

OUTinst <= x"01010200" after 2 ns, x"01060200" after 5 ns, x"01070200" AFTER 10 ns,
x"01070200" after 15 ns,x"01080200" after 15 ns,
x"010A0200" after 20 ns, x"010B0200" after 25 ns ;


end ;
