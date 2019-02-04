LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY semaforo IS
PORT (clk : IN STD_LOGIC;
		verde1, amarelo1, vermelho1 : OUT STD_LOGIC;
		verde2, amarelo2, vermelho2 : OUT STD_LOGIC);
END semaforo;

ARCHITECTURE main OF semaforo IS
TYPE estado IS (estado1, estado2, estado3, estado4);
SIGNAL estadoAtual, estadoFuturo : estado;

SIGNAL contador : NATURAL RANGE 29 DOWNTO 0 := 0;
BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN			
			contador <= contador + 1;
			estadoAtual <= estadoFuturo;
			IF(contador = 29) THEN
				contador <= 0;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(estadoAtual,contador)
	BEGIN
		IF(estadoAtual = estado1) THEN
			IF(contador < 12) THEN				
				verde1 	 <= '1';
				verde2 	 <= '0';
				amarelo1  <= '0';
				amarelo2  <= '0';
				vermelho1 <= '0';
				vermelho2 <= '1';
				estadoFuturo <= estado2;
			END IF;
		ELSIF(estadoAtual = estado2) THEN
			IF(contador >= 12 AND contador < 15) THEN				
				verde1 	 <= '0';
				verde2 	 <= '0';
				amarelo1  <= '1';
				amarelo2  <= '0';
				vermelho1 <= '0';
				vermelho2 <= '1';
				estadoFuturo <= estado3;
			END IF;
		ELSIF(estadoAtual = estado3) THEN
			IF(contador >= 15 AND contador < 27) THEN				
				verde1 	 <= '0';
				verde2 	 <= '1';
				amarelo1  <= '0';
				amarelo2  <= '0';
				vermelho1 <= '1';
				vermelho2 <= '0';
				estadoFuturo <= estado4;
			END IF;
		ELSE
			IF(contador > 27) THEN				
				verde1 	 <= '0';
				verde2 	 <= '0';
				amarelo1  <= '0';
				amarelo2  <= '1';
				vermelho1 <= '1';
				vermelho2 <= '0';
				estadoFuturo <= estado1;
			END IF;
		END IF;
	END PROCESS;	
END main;