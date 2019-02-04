LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY relogio IS
PORT(clk 	  : IN STD_LOGIC;
	  display1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	  display2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	  display3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	  saidaMin,saidaSeg : OUT NATURAL RANGE 59 DOWNTO 0);
END relogio;

ARCHITECTURE main OF relogio IS
SIGNAL hora : NATURAL RANGE 11 DOWNTO 0 := 0;
SIGNAL min	: NATURAL RANGE 59 DOWNTO 0 := 0;
SIGNAL seg	: NATURAL RANGE 59 DOWNTO 0 := 0;	

BEGIN
	PROCESS (clk)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			seg <= seg + 1;
			IF(seg = 59) THEN
				seg <= 0;
				min <= min + 1;
			END IF;
			
			IF(min = 59 AND seg = 59) THEN
				min  <= 0;
				seg  <= 0;
				hora <= hora + 1;
			END IF;
		END IF;
	END PROCESS;
	
	saidaMin <= min;
	saidaSeg <= seg;
	
	display3 <= "1000000" WHEN (hora = 0)  ELSE
					"1111001" WHEN (hora = 1)  ELSE
					"0100100" WHEN (hora = 2)  ELSE
					"0110000" WHEN (hora = 3)  ELSE
					"0011001" WHEN (hora = 4)  ELSE
					"0010010" WHEN (hora = 5)  ELSE
					"0000010" WHEN (hora = 6)  ELSE
					"1111000" WHEN (hora = 7)  ELSE
					"0000000" WHEN (hora = 8)  ELSE
					"0011000" WHEN (hora = 9)  ELSE
					"0001000" WHEN (hora = 10) ELSE
					"0000011" WHEN (hora = 11) ELSE
					"1000110" WHEN (hora = 12) ELSE
					"0100001" WHEN (hora = 13) ELSE
					"0000110" WHEN (hora = 14) ELSE
					"0001110";
						
		display2 <= "1000000" WHEN (min >= 0 AND min < 10)  ELSE
						"1111001" WHEN (min >= 10 AND min < 20) ELSE
						"0100100" WHEN (min >= 20 AND min < 30) ELSE
						"0110000" WHEN (min >= 30 AND min < 40) ELSE
						"0011001" WHEN (min >= 40 AND min < 50) ELSE
						"0010010" WHEN (min >= 50 AND min < 60) ELSE
						"0000010";

			display1 <= "1000000" WHEN (min = 0 OR min = 10 OR min = 20 OR min = 30 OR min = 40 OR min = 50) ELSE
							"1111001" WHEN (min = 1 OR min = 11 OR min = 21 OR min = 31 OR min = 41 OR min = 51) ELSE
							"0100100" WHEN (min = 2 OR min = 12 OR min = 22 OR min = 32 OR min = 42 OR min = 52) ELSE
							"0110000" WHEN (min = 3 OR min = 13 OR min = 23 OR min = 33 OR min = 43 OR min = 53) ELSE
							"0011001" WHEN (min = 4 OR min = 14 OR min = 24 OR min = 34 OR min = 44 OR min = 54) ELSE
							"0010010" WHEN (min = 5 OR min = 15 OR min = 25 OR min = 35 OR min = 45 OR min = 55) ELSE
							"0000010" WHEN (min = 6 OR min = 16 OR min = 26 OR min = 36 OR min = 46 OR min = 56) ELSE
							"1111000" WHEN (min = 7 OR min = 17 OR min = 27 OR min = 37 OR min = 47 OR min = 57) ELSE
							"0000000" WHEN (min = 8 OR min = 18 OR min = 28 OR min = 38 OR min = 48 OR min = 58) ELSE
							"0011000" WHEN (min = 9 OR min = 19 OR min = 29 OR min = 39 OR min = 49 OR min = 59) ELSE
							"0001000";
	
	
END main;