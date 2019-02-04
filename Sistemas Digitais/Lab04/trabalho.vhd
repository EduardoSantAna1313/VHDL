LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY trabalho IS
	PORT(a, b  : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
		  saida : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END trabalho;

ARCHITECTURE main OF trabalho IS
BEGIN

		saida <= "0000" WHEN (a = "00" OR  b = "00") ELSE
					"0001" WHEN (a = "01" AND b = "01") ELSE
					"0010" WHEN (a = "01" AND b = "10") ELSE
					"0010" WHEN (a = "10" AND b = "01") ELSE
					"0011" WHEN (a = "01" AND b = "11") ELSE
					"0011" WHEN (a = "11" AND b = "01") ELSE
					"0100" WHEN (a = "10" AND b = "10")	ELSE
					"0110" WHEN (a = "11" AND b = "10") ELSE
					"0110" WHEN (a = "10" AND b = "11") ELSE
					"1001" WHEN (a = "11" AND b = "11"); 

END main;