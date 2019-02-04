LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY detector IS
	PORT(caracter : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		  clk		  : IN  STD_LOGIC;
		  ligar	  : IN  STD_LOGIC;
		  saida 	  : OUT STD_LOGIC;
		  saidaEst : OUT NATURAL RANGE 1 DOWNTO 5);
END detector;

ARCHITECTURE main OF detector IS
SIGNAL stop : STD_LOGIC := '0';
TYPE estado IS(estado1, estado2,estado3, estado4, estado5);
SIGNAL estadoAtual, estadoFuturo : estado;
BEGIN

	--D = 0100 0100
	--E = 0100 0101
	--L = 0100 1100
	--T = 0101 0100
	--A = 0100 0001
	PROCESS(clk, estadoAtual)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
				
			estadoAtual <= estadoFuturo;
			
			IF(estadoAtual = estado1) THEN
				saidaEst <= 1;
				IF(caracter = "01000100") THEN
					estadoFuturo <= estado2;
				ELSE
					estadoFuturo <= estado1;
				END IF;
				saida<= '0';
			ELSIF(estadoAtual = estado2) THEN
				saidaEst <= 2;
				IF(caracter = "01000101") THEN
					estadoFuturo <= estado3;
				ELSE
					estadoFuturo <= estado1;
				END IF;
				saida <= '0';
			ELSIF(estadoAtual = estado3) THEN
				saidaEst <= 3;
				IF(caracter = "01001100") THEN
					estadoFuturo <= estado4;
				ELSE
					estadoFuturo <= estado1;
				END IF;
				saida <= '0';
			ELSIF (estadoAtual = estado4) THEN
				saidaEst <= 4;
				IF(caracter = "01010100") THEN
					estadoFuturo <= estado5;
				ELSE
					estadoFuturo <= estado1;
				END IF;
				saida <= '1';
			ELSIF (estadoAtual = estado5) THEN
				saidaEst <= 5;
				IF(caracter = "01001100") THEN
					estadoFuturo <= estado1;
					stop <= '0';
					saida <= '1';
				ELSE
					estadoFuturo <= estado1;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END main;