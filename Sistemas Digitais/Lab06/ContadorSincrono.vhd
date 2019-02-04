LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ContadorSincrono IS
	PORT(clk 	 : IN STD_LOGIC;
		  sentido : IN BIT;
		  q		 : OUT NATURAL RANGE 99 DOWNTO 0);
END ContadorSincrono;

ARCHITECTURE main OF ContadorSincrono IS
BEGIN	
	PROCESS(clk)
		VARIABLE x : NATURAL RANGE 99 DOWNTO 0 := 10;
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			IF(sentido = '0') THEN		
				x := x - 1;
				IF(x = 127) THEN
					x := 99;
				END IF;
			ELSE
				x := x + 1;
				IF(x = 100) THEN
					x := 0;
				END IF;
			END IF;		
		END IF;

		q <= x;
	END PROCESS;
	
	
END main;
