LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_signed.all; 
use work.all;
ENTITY Project3 IS 
    PORT ( DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
           Resetn, Clock, Run : IN STD_LOGIC; 
           Done : BUFFER STD_LOGIC; 
           BusWires : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0);
			  Overflow:out std_LOGIC); 
			  
END Project3;

ARCHITECTURE Behavior OF Project3 IS 
signal Rin,Rout,Xreg,Yreg: std_logic_vector(0 to 7);
signal Clear,high,Ov:std_logic;
signal Ain,Gin,Gout,IRin,DINout:std_logic;
signal T:std_logic_vector(1 downto 0);
signal I,Aluop:std_logic_vector(0 to 2);
signal R0,R1,R2,R3,R4,R5,R6,R7,R0out,R1out,R2out,R3out,R4out,R5out,R6out,R7out,DINo,Go:STD_LOGIC_VECTOR(15 downto 0);
signal A,G,ALU1,B:std_logic_vector(15 downto 0);
signal IR:std_logic_vector(8 DOWNto 0);
 Component alu
 port(ALUct1:in std_LOGIC_VECTOR(0 to 2);A,B:IN STD_LOGIC_VECTOR(15 DOWNTO 0);ALUout:OUT STD_LOGIC_VECTOR(15 DOWNTO 0);Cout:out std_LOGIC);
 END component;
 COMPONent regn
 port(R:in std_LOGIC_VECTOR(15 downto 0);Rin,Clock:in std_LOGIC;Q:buffer std_lOGIC_VECTOR(15 downto 0));
 end component;
 COMPONent regn9
 port(R:in std_LOGIC_VECTOR(8 downto 0);Rin,Clock:in std_LOGIC;Q:buffer std_lOGIC_VECTOR(8 downto 0));
 end component;
BEGIN 
  High <= '1'; 
  Clear <= Resetn OR Done ;
  Tstep: upcount PORT MAP (Clear, Clock, T);
  I <= IR(8 DOWNTO 6);
  decX: dec3to8 PORT MAP (IR(5 DOWNTO 3), High, Xreg);
  decY: dec3to8 PORT MAP (IR(2 DOWNTO 0), High, Yreg);
  controlsignals: PROCESS (T, I, Xreg, Yreg) 

  BEGIN
  IRin<='0';
  Done<='0'; 
  Ain<='0'; 
  DINout<='0'; 
  Aluop <= "000";
  Gin<='0'; 
  Gout<='0'; 
  Rin<="00000000"; 
  Rout<="00000000";
    CASE T IS 
   
      WHEN "00" =>  
        IRin <= '1'; 
      WHEN "01" =>  
        CASE I IS 
         when "000" => Rout<=Yreg;  Rin<=Xreg;  Done<='1'; 
			when "001"=> DINout<='1'; Rin<=Xreg; Done<='1'; 
			when others=> Rout<=Xreg; Ain<='1'; 
        

        END CASE; 
      WHEN "10" => 
        CASE I IS 
		when "000"=>
		when "001"=>
		when others=> Rout<=Yreg; Aluop<=I; Gin<='1'; 

         

        END CASE; 
      WHEN "11" =>  
        CASE I IS 
			when "000"=>
			when "001"=>
			when others=> Gout<='1'; Rin<=Xreg; Done<='1'; 
       
        END CASE; 
    END CASE; 
  END PROCESS; 
  B<="0000000000000000";
    IRfunc: regn9 port map(DIN(15 DOWNTO 7),IRin,Clock,IR);
  reg_0: regn PORT MAP (BusWires, Rin(0), Clock, R0);
  reg_1: regn port map (BusWires, Rin(1), Clock, R1);
  reg_2: regn port map (BusWires, Rin(2), Clock, R2);
  reg_3: regn port map (BusWires, Rin(3), Clock, R3);
  reg_4: regn port map (BusWires, Rin(4), Clock, R4);
  reg_5: regn port map (BusWires, Rin(5), Clock, R5);
  reg_6: regn port map (BusWires, Rin(6), Clock, R6);
  reg_7: regn port map (BusWires, Rin(7), Clock, R7);
  regG: regn port map(ALU1,Gin,Clock,G);		
  regA: regn port map(BusWires,Ain,Clock,A);
  mux0: mux2to1 port map(Rout(0),R0,B,R0out);
  mux1: mux2to1 port map(Rout(1),R1,B,R1out);
  mux2: mux2to1 port map(Rout(2),R2,B,R2out);
  mux3: mux2to1 port map(Rout(3),R3,B,R3out);
  mux4: mux2to1 port map(Rout(4),R4,B,R4out);
  mux5: mux2to1 port map(Rout(5),R5,B,R5out);
  mux6: mux2to1 port map(Rout(6),R6,B,R6out);
  mux7: mux2to1 port map(Rout(7),R7,B,R7out);
  muxD: mux2to1 port map(DINout,DIN,B,DINo);
  muxG: mux2to1 port map(Gout,G,B,Go);
  BusWires<=R0out or R1out or R2out or R3out or R4out or R5out or R6out or R7out or DINo or Go;
  alu2: alu port map(Aluop,A,BusWires,ALU1,Ov);
    proCESS(T)
	 BEGIN
	 if T="10" THEN
	 Overflow<=Ov;
	 ELSE 
	 Overflow<='0';
	 end if;
	 END PROCESS;
END Behavior; 