LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY trabalho IS
	PORT(a, b : IN BIT;
		 saida_xor, saida_xnor    : OUT BIT);
END trabalho;

ARCHITECTURE main OF trabalho IS
BEGIN
	saida_xor  <= (not(a) and b) or (a and (not(b))); 
	saida_xnor <= (not(a) and not(b)) or (a and b); 
END main;