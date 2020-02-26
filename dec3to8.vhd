LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY dec3to8 IS


  PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
  En : IN STD_LOGIC; 
  Y : OUT STD_LOGIC_VECTOR(0 TO 7)); 
END dec3to8; 

ARCHITECTURE Behavior OF dec3to8 IS 

BEGIN 
  PROCESS (W, En) 
  BEGIN 

    IF En = '1' THEN 

      CASE W IS 
			when "000"=> y<="10000000";
			when "001"=> y<="01000000";
			when "010"=> y<="00100000";
			when "011"=> y<="00010000";
			when "100"=> y<="00001000"; 
			when "101"=> y<="00000100";
			when "110"=> y<="00000010";
			when "111"=> y<="00000001";
      
  
      END CASE; 
    ELSE 
      Y <= "00000000"; 
    END IF; 
   END PROCESS; 
END Behavior; 