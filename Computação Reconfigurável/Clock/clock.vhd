LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Clock IS
PORT(clockplaca : IN STD_LOGIC;
	  clk			 : OUT STD_LOGIC);
END Clock;

ARCHITECTURE main OF Clock IS
	SIGNAL mensagem : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00111000";
	SIGNAL x			 : STD_LOGIC 							:= '0';
BEGIN
	PROCESS(clockplaca, mensagem)
		VARIABLE indice : NATURAL RANGE 7 DOWNTO 0 := 0;
	BEGIN
		IF(clockplaca'EVENT AND clockplaca = '1') THEN
			indice := indice + 1;			
		END IF;
		x <= clockplaca XOR mensagem(indice);
	END PROCESS;
	clk <= x;
END main;