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
 RST : in STD_LOGIC
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
Component etage3 port( Ain : in STD_LOGIC_VECTOR (7 downto 0);
                 OPin : in STD_LOGIC_VECTOR (3 downto 0);
                 Bin : in STD_LOGIC_VECTOR (7 downto 0);
                 Aout : out STD_LOGIC_VECTOR (7 downto 0);
                 Bout : out STD_LOGIC_VECTOR (7 downto 0);
                 CLK : in STD_LOGIC;
                 OPout : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component MuxBr is
    Port ( OP : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);          
           QA : in STD_LOGIC_VECTOR (7 downto 0);
           outMux : out STD_LOGIC_VECTOR (7 downto 0));
end component;


Component muxALU Port 
    ( OP : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (7 downto 0);
       S_ALU : in STD_LOGIC_VECTOR (7 downto 0);
       S : out STD_LOGIC_VECTOR (7 downto 0));
end component;

Component muxIN_MB port( A : in STD_LOGIC_VECTOR (7 downto 0);
           OP : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           mux_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;


Component mux_outMB port( OUTmb : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           OP : in STD_LOGIC_VECTOR (3 downto 0);
           out_mux : out STD_LOGIC_VECTOR (7 downto 0));
end component;


component LC_MB Port (
 OP : in STD_LOGIC_VECTOR (3 downto 0);
           s : out STD_LOGIC);
end component;

component lc_ALU port ( 
    OP : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component LC_mr port ( 
    OP : in STD_LOGIC_VECTOR (3 downto 0);
    s : out STD_LOGIC);
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
  signal lidi_c2BR :  STD_LOGIC_VECTOR (7 downto 0);
  signal BR2diex_c:  STD_LOGIC_VECTOR (7 downto 0);
  signal lidi_op2diex :  STD_LOGIC_VECTOR (3 downto 0);
 
 
signal diex_a2em:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_b2em:  STD_LOGIC_VECTOR (7 downto 0);
signal muxAlu2em_b:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_c2em:  STD_LOGIC_VECTOR (7 downto 0);
signal diex_op2em:  STD_LOGIC_VECTOR (3 downto 0);
 
 signal em_a2mr:  STD_LOGIC_VECTOR (7 downto 0);
signal  em_b2mr:  STD_LOGIC_VECTOR (7 downto 0);

signal muxMB2mr: STD_LOGIC_VECTOR (7 downto 0);
signal em_op2mr:  STD_LOGIC_VECTOR (3 downto 0);


signal mem_re_b2DATA:  STD_LOGIC_VECTOR (7 downto 0);


signal a_MI: std_logic_vector(7 downto 0);

signal qa2mux1:std_logic_vector(7 downto 0);
signal muxAlu2em: std_logic_vector(7 downto 0);

signal muxatMB: std_logic_vector(7 downto 0);

signal OutMb2mux4: STD_LOGIC_VECTOR (7 downto 0) ;

signal mr2rb_atW: STD_LOGIC_VECTOR (7 downto 0) ;


signal lc2ALU: std_logic_vector(2 downto 0);
signal lc2_rw_mb: std_logic :='0';
signal mr_op2lc: std_logic_VECTOR (3 downto 0) ;

signal lc2_wBR: std_logic;


signal S_Alu: std_logic_vector(7 downto 0);




begin



instbank: MemInst port map(
    at=>a_MI,
    CLK=>CLK,
    OUTinst(7 downto 0) =>mi2lidi_a,
    OUTinst(15 downto 8) =>mi2lidi_op,
    OUTinst(23 downto 16) =>mi2lidi_b,
    OUTinst(31 downto 24) =>mi2lidi_c
    );

 RegisBank: RegBank port map(
     atA=>lidi_b2diex(3 downto 0),
     atB=>lidi_c2BR (3 downto 0),
     atW=>mr2rb_atW(3 downto 0),
     W=>lc2_wBR,
     DATA=>mem_re_b2DATA,
     RST=>RST,
     CLK=>CLK,
     QA=>qa2mux1,
     QB=>BR2diex_c    
 );
 ALUpip: ALU PORT MAP(
        A=>diex_b2em,
        B =>diex_c2em,
        S=>S_Alu,
        Ctrl_Alu=>lc2ALU

        );
        
  MB: MemBank port map(
        at=>muxAtMB,
        INmb=>em_b2mr,
        RW=>lc2_rw_mb,
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
    Cout =>lidi_c2BR);
    
    DIEX: etage4 port map(
        Ain => lidi_a2diex,      
        OPin => lidi_op2diex,
        Bin => lidi_b2diex, 
        Cin => BR2diex_c,
        Aout=> diex_a2em,
        OPout => diex_op2em,
        Bout => diex_b2em,
        CLK => CLK,
        Cout =>diex_c2em);
        
  EXMEM :etage3 port map(
    Ain => diex_a2em,      
    OPin => diex_op2em,
    Bin => muxAlu2em_b, --Sortie de MUXALU
    Aout=> em_a2mr,
    OPout => em_op2mr,
    Bout => em_b2mr,
    CLK => CLK );
                
 MEMRE :etage3 port map(
    Ain => em_a2mr,      
    OPin => em_op2mr,
    Bin => muxMB2mr, 
    Aout=> mr2rb_atW,
    OPout => mr_op2lc,
    Bout => mem_re_b2DATA,
    CLK => CLK );
   
      
        
MuxbrC: MuxBR port map(  
    OP=>lidi_op2diex,
    B=>lidi_b2diex,
    QA=>qa2mux1,
    outMux => muxAlu2em);
    
   
MuxALUc: MuxALU port map(  
        OP=>lidi_op2diex,
        B=>lidi_b2diex,
        S_ALU=>S_ALU,
        s => muxAlu2em_b);
       
MuxMBrw: MUxIN_MB port map(
    A => em_a2mr,
    OP => em_op2mr,
    B => em_b2mr,
    mux_out => muxAtMB);
  
  
muxMRb: MUX_outMB port map(
     OUTmb =>OutMb2mux4,
     B => em_b2mr,
     OP => em_op2mr,
     out_mux=> muxMB2mr);
     
lcALU: lc_alu port map(
    OP=>diex_op2em,
    S=>lc2ALU
);
     
lcmb: lc_mb port map(
    OP =>  em_op2mr,
    S=>   lc2_rw_mb);
    
lcmr: lc_mr port map(
    OP=>mr_op2lc,
    S=>lc2_wBR);
     
process
begin 
    wait until CLK'event and CLK='1';

        



end process;
end Behavioral;
