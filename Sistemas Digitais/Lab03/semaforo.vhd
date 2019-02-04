LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY semaforo IS
	PORT(A, B, C, D : IN STD_LOGIC;
		  LO, NS 	 : OUT STD_LOGIC);
END SEMAFORO;

ARCHITECTURE main OF semaforo IS
BEGIN
	LO <= ((NOT A AND NOT B) OR D);
	NS <= (NOT(C) AND A) OR (NOT(D) AND B);
		
END main;