LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY contador IS
	PORT(clk : IN STD_LOGIC;
		  Q	: OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
END contador;

ARCHITECTURE main OF contador IS
SIGNAL x : STD_LOGIC_VECTOR (4 DOWNTO 0) := "00000";
BEGIN	
	PROCESS(clk, x(0), x(1), x(2), x(3), x(4))
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			x(0) <= NOT x(0);
		END IF;
		IF (x(0)'EVENT AND x(0) = '0') THEN
			x(1) <= NOT x(1);
		END IF;
		IF (x(1)'EVENT AND x(1) = '0') THEN
			x(2) <= NOT x(2);
		END IF;
		IF (x(2)'EVENT AND x(2) = '0') THEN
			x(3) <= NOT x(3);
		END IF;
		IF (x(3)'EVENT AND x(3) = '0') THEN
			x(4) <= NOT x(4);
		END IF;		
	END PROCESS;	
	Q <= x;
END main;

