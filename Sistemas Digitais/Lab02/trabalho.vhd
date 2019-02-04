LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY trabalho IS
	PORT(entrada : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		  sel     : IN BIT;
		  saida   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END trabalho;

ARCHITECTURE main OF trabalho IS
BEGIN
	saida <= "1000000" WHEN entrada = "0000" ELSE
				"1111001" WHEN entrada = "0001" ELSE
				"0100100" WHEN entrada = "0010" ELSE
				"0110000" WHEN entrada = "0011" ELSE
				"0011001" WHEN entrada = "0100" ELSE
				"0010010" WHEN entrada = "0101" ELSE
				"0000010" WHEN entrada = "0110" ELSE
				"1111000" WHEN entrada = "0111" ELSE
				"0000000" WHEN entrada = "1000" ELSE
				"0011000" WHEN entrada = "1001" ELSE
				"0001000" WHEN entrada = "1010" ELSE
				"0000011" WHEN entrada = "1011" ELSE
				"1000110" WHEN entrada = "1100" ELSE
				"0100001" WHEN entrada = "1101" ELSE
				"0000110" WHEN entrada = "1110" ELSE
				"0001110";

END main;