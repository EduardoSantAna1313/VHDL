LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MaquinaDeLavar IS
PORT(sc 			: IN STD_LOGIC;
	  sv 			: IN STD_LOGIC;
	  clk 		: IN STD_LOGIC;	
	  B 			: OUT STD_LOGIC;
	  V 			: OUT STD_LOGIC;
	  M 			: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
	  saidaClk 	: BUFFER BIT;
	  btnLigar 	: IN STD_LOGIC);
END MaquinaDeLavar;

ARCHITECTURE main OF MaquinaDeLavar IS
	TYPE estado IS (parado, enchendo, ciclo, esvaziando);
	SIGNAL estadoAtual, estadoFuturo : estado;
	
	SIGNAL contador : NATURAL RANGE 120 DOWNTO 0 := 0;
	SIGNAL cont2m, cont20s : STD_LOGIC := '0';
	SIGNAL ligar : STD_LOGIC := '0';
BEGIN

	PROCESS(clk, estadoAtual, btnLigar)
	BEGIN
		IF(clk'EVENT AND clk= '1') THEN
			estadoAtual <= estadoFuturo;
			saidaClk <= (saidaClk xor '1');
			
			IF(btnLigar = '1') THEN
				ligar <= '1';
			END IF;
			
			IF(estadoAtual = ciclo) THEN
				ligar <= '0';
			END IF;
			
			IF(estadoAtual = ciclo) THEN 
				contador <= contador + 1;
				IF(contador = 19) THEN
					cont20s <= '1';
					cont2m <= '0';
				ELSIF(contador = 39) THEN
					cont20s <= '0';
					cont2m <= '0';
				ELSIF(contador = 59) THEN
					cont20s <= '1';
					cont2m <= '0';
				ELSIF(contador = 79) THEN
					cont20s <= '0';
					cont2m <= '0';
				ELSIF(contador = 99) THEN
					cont20s <= '1';
					cont2m <= '0';
				ELSIF(contador = 119) THEN
					cont20s <= '0';
					cont2m <= '1';
					contador <= 0;
				ELSE
					cont2m <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(estadoAtual, sc,sv, cont2m, ligar)
	BEGIN
		IF (estadoAtual = parado) THEN
			IF(sc = '0' AND sv = '1' AND cont2m = '0' AND ligar = '1') THEN
				estadoFuturo <= enchendo;
			ELSE
				estadoFuturo <= parado;
			END IF;
		ELSIF (estadoAtual = enchendo) THEN
			IF(sc = '1' AND sv = '0' AND cont2m = '0' AND ligar = '1') THEN
				estadoFuturo <= ciclo;
			ELSE
				estadoFuturo <= enchendo;
			END IF;
		ELSIF (estadoAtual = ciclo) THEN
			IF (cont2m = '1') THEN
				estadoFuturo <= esvaziando;
			ELSE
				estadoFuturo <= ciclo;
			END IF;			
		ELSE
			IF(sc = '0' AND sv = '1') THEN
				estadoFuturo <= parado;
			ELSE
				estadoFuturo <= esvaziando;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(estadoAtual, cont20s)
	BEGIN
		IF (estadoAtual = parado) THEN
			M <= "00";
			V <= '0';
			B <= '0';
		ELSIF (estadoAtual = enchendo) THEN
			M <= "00";
			V <= '1';
			B <= '0';
		ELSIF (estadoAtual = ciclo) THEN
			B <= '0';
			V <= '0';
			IF(cont20s = '0') THEN
				M <= "10";
			ELSE
				M <= "01";
			END IF;
		ELSE
			M <= "00";
			V <= '0';
			B <= '1';
		END IF;
	END PROCESS;
END main;