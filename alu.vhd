LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY alu IS
   PORT (ALUct1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
         A,B: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
         ALUout: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			Cout:Out std_logic);
END alu;
ARCHITECTURE Behavior of ALU IS
Signal temp_output,F: std_logic_vector (15 downto 0);
  signal result : std_logic_vector(16 downto 0);
  
BEGIN 

    Process(ALUct1, A, B)
    BEGIN
        case Aluct1 Is
         when "010" =>
              temp_output <= A and B;
         when "011" =>
              temp_output <=  A or B;
         when "100" => result <= ('0' & A) + ('0' & B);
								F      <= result(15 downto 0);
								Cout   <= result(16);
								temp_output <= A + B;
								
         when "101" =>
              temp_output <= A - B;
		 when "110" =>
             temp_output <= A xor B;
         when "111" =>
             temp_output <= not A;
         when others =>
              temp_output <= "0000000000000000";
       End Case;
  END PROCESS;
      ALUout <= temp_output;
END Behavior;