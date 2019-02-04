LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY transmissor IS
	PORT(saida  				: OUT STD_LOGIC;
		  clkPlaca 				: IN  STD_LOGIC;
		  mensagem 			 	: IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
		  saidaMsg 				: OUT STD_LOGIC_VECTOR (0 TO 7);
		  btn						: IN  STD_LOGIC;
		  saidaClkDobro		: OUT STD_LOGIC;
		  saidaClk				: OUT STD_LOGIC;
		  saidaCont				: OUT NATURAL);
END transmissor;

ARCHITECTURE main OF transmissor IS
	SIGNAL mensagemCodificada 	: STD_LOGIC_VECTOR (0 TO 7)  		:= "00000000";
	--SIGNAL mensagem 			: STD_LOGIC_VECTOR (0 TO 3) 	:= "0101";
	SIGNAL clk						: STD_LOGIC 							:= '0';
	SIGNAL codificado : STD_LOGIC;
	SIGNAL clkDobro : STD_LOGIC;
	SIGNAL indice2   : NATURAL RANGE 0 TO 7 := 0; 
BEGIN

	PROCESS(clkPlaca)
		VARIABLE contador : NATURAL RANGE 39 DOWNTO 0 := 0;
	BEGIN
		IF(clkPlaca'EVENT AND clkPlaca ='1') THEN
			IF(contador < 20) THEN
				IF(contador = 9) THEN
					clkDobro <= clkDobro XOR '1';
				ELSIF(contador = 19) THEN
					clkDobro <= clkDobro XOR '1';
					clk      <= clk XOR '1';
				END IF;			
			ELSE
				IF(contador = 29) THEN
					clkDobro <= clkDobro XOR '1';
				ELSIF(contador = 39) THEN
					clkDobro <= clkDobro XOR '1';
					clk      <= clk XOR '1';
				END IF;
			END IF;		
			contador := contador + 1;
			IF(contador = 40) THEN
				contador := 0;
			END IF;			
		END IF;
		--saidacontador <= contador;
	END PROCESS;
	
	saidaClkDobro <= clkDobro;
	saidaClk		  <= clk;
	
	PROCESS(clkDobro)
			--VARIABLE indice2   : NATURAL RANGE 0 TO 8;
		VARIABLE contador2 : NATURAL RANGE 10 DOWNTO 0:= 0;
	BEGIN
		IF(codificado = '1') THEN
			IF(contador2 < 2) THEN
				saida <= '1';
			ELSE
				saida <= mensagemCodificada(indice2) XNOR clkDobro;
			END IF;
		END IF;
		IF(clkDobro'EVENT AND clkDobro = '1') THEN
			indice2 <= indice2 + 1;
			contador2 := contador2 + 1;
			IF(contador2 = 10) THEN
				contador2 := 0;
			END IF;
		END IF;	
		saidaCont <= contador2;
	END PROCESS;
	
	saidaMsg <= mensagemCodificada;

	PROCESS(clk,mensagem, btn)
		VARIABLE estado 	  : NATURAL RANGE 0 TO 4 := 0;
		VARIABLE indice	  : NATURAL RANGE 0 TO 4 := 0;
		VARIABLE i 		 	  : NATURAL RANGE 0 TO 7 := 0;
		VARIABLE mensagemAntiga : STD_LOGIC_VECTOR (0 TO 3) := "0000";
		--VARIABLE codificado : STD_LOGIC 				 := '0';
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			IF(codificado = '0') THEN
				FOR indice IN 0 TO 3 LOOP
					IF(mensagem(indice) = '0') THEN
						IF(estado = 0) THEN
							mensagemCodificada(indice*2) 		<= '0';
							mensagemCodificada(indice*2 + 1) <= '0';
							estado := 0;
						ELSIF(estado = 1) THEN
							mensagemCodificada(indice*2) 		<= '1';
							mensagemCodificada(indice*2 + 1) <= '1';
							estado := 0;			
						ELSIF(estado = 2) THEN
							mensagemCodificada(indice*2) 		<= '1';
							mensagemCodificada(indice*2 + 1) <= '0';
							estado := 1;				
						ELSIF(estado = 3) THEN
							mensagemCodificada(indice*2) 		<= '0';
							mensagemCodificada(indice*2 + 1) <= '1';
							estado := 1;				
						END IF;
					ELSE
						IF(estado = 0) THEN
							mensagemCodificada(indice*2) 		<= '1';
							mensagemCodificada(indice*2 + 1) <= '1';
							estado := 2;
						ELSIF(estado = 1) THEN
							mensagemCodificada(indice*2) 		<= '0';
							mensagemCodificada(indice*2 + 1) <= '0';
							estado := 2;			
						ELSIF(estado = 2) THEN
							mensagemCodificada(indice*2) 		<= '0';
							mensagemCodificada(indice*2 + 1) <= '1';
							estado := 3;				
						ELSIF(estado = 3) THEN
							mensagemCodificada(indice*2) 		<= '1';
							mensagemCodificada(indice*2 + 1) <= '0';
							estado := 3;				
						END IF;
					END IF;	
				END LOOP;
				codificado <= '1';
				mensagemAntiga := mensagem;
			END IF;
			
			IF(mensagemAntiga /= mensagem) THEN
				codificado <= '0';
				estado     := 0;
				mensagemCodificada <= "00000000";
			END IF;					 
		END IF;		
	END PROCESS;
	
END main;
