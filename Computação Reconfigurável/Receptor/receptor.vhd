LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY receptor IS
	PORT(entrada 		 			: IN  STD_LOGIC;
		  clkPlaca 		 			: IN  STD_LOGIC;
		  clock						: IN STD_LOGIC;
		  saidamensagem 			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		  saidamsgdecodificada 	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		  saidaIndice				: OUT STD_LOGIC;
		  saidaEstadoAtual		: OUT NATURAL;
		  saidaFlag					: OUT STD_LOGIC;
		  saidaFlagFuncao			: OUT STD_LOGIC;
		  saidaIndex				: OUT NATURAL;
		  saidaVetor				: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END receptor;

ARCHITECTURE main OF receptor IS
	SIGNAL mensagem 				 : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
	SIGNAL mensagemDecodificada : STD_LOGIC_VECTOR(3 DOWNTO 0)  := "0000";	
	SIGNAL decodificada   		 : STD_LOGIC 							:= '0';
	SIGNAL erro 					 : STD_LOGIC 							:= '0';
	SIGNAL decodificadaXOR		 : STD_LOGIC 							:= '0';
	SIGNAL flag						 : STD_LOGIC							:= '0';
	SIGNAL chegou15				 : STD_LOGIC							:= '0';
BEGIN

	PROCESS(clock, entrada, flag)
		VARIABLE vetor				 : STD_LOGIC_VECTOR (15 DOWNTO 0);
		VARIABLE indiceEntrada   : NATURAL RANGE 15 DOWNTO 0 := 0;
		VARIABLE indiceConversao : NATURAL RANGE 7 DOWNTO 0 := 0;
	BEGIN
		IF(clock'EVENT AND clock = '0' AND flag = '1') THEN
			vetor(indiceEntrada) := entrada XOR '0';
			indiceEntrada := indiceEntrada + 1;
			IF(indiceEntrada = 15) THEN
				indiceEntrada := 0;
				saidaIndice <= '1';
				chegou15    <= '1';
				FOR indiceConversao IN 0 TO 7 LOOP
					mensagem(indiceConversao) <= vetor(indiceConversao*2);
					decodificadaXOR <= '1';
				END LOOP;
				--flag <= '0';
			ELSE
				saidaIndice <= '0';
				chegou15 <= '0';
				mensagem <= "00000000";
				decodificadaXOR <= '0';
			END IF;
		END IF;
		saidaVetor <= vetor;
		saidaIndex <= indiceEntrada;
	END PROCESS;
	
	PROCESS(clock, entrada)
		VARIABLE ea : NATURAL RANGE 4 DOWNTO 0 := 0;
		VARIABLE ef : NATURAL RANGE 4 DOWNTO 0 := 0;
	BEGIN
		IF(clock'EVENT AND clock = '0') THEN
			ea := ef;
		END IF;
		
		IF(entrada = '0') THEN
			IF(ea = 0) THEN
				ef := 0;
			ELSIF(ea = 1) THEN
				ef := 0;
			ELSIF(ea = 2) THEN
				ef := 0;
			ELSIF(ea = 3) THEN
				ef := 0;
			ELSIF(ea = 4) THEN
				ef := 0;
			END IF;
		
		ELSE
			IF(ea = 0) THEN
				ef := 1;
			ELSIF(ea = 1) THEN
				ef := 2;
			ELSIF(ea = 2) THEN
				ef := 3;
			ELSIF(ea = 3) THEN
				ef := 4;
			ELSIF(ea = 4) THEN
				ef := 0;
			END IF;
		END IF;
		
		IF(ea = 4) THEN
			flag <= '1';
		ELSE
			IF(chegou15 = '1') THEN
				flag <= '0';
			END IF;
		END IF;
		
		saidaEstadoAtual <= ea;
	END PROCESS;
	saidamensagem <= mensagem;
	saidaFlag 	  <= flag;
	
	PROCESS(clkPlaca, decodificadaXOR, decodificada)
		VARIABLE indice : NATURAL RANGE 7 DOWNTO 0 := 0;
		VARIABLE i : NATURAL;
		VARIABLE estado : NATURAL RANGE 3 DOWNTO 0 := 0;
		
		VARIABLE mensagemAntiga : STD_LOGIC_VECTOR (3 DOWNTO 0);
	BEGIN	
		IF(clkPlaca'EVENT AND clkPlaca = '1') THEN
			IF(decodificada = '0' AND decodificadaXOR = '1') THEN				
				FOR i IN 0 TO 3 LOOP
					IF(mensagem(i*2) = '0' AND mensagem((i*2)+1) = '0') THEN 
						IF(estado = 0) THEN
							mensagemDecodificada(i) <= '0';
							estado := 0;
							erro <= '0';
						ELSIF(estado = 1) THEN
							mensagemDecodificada(i) <= '1';
							estado := 2;
							erro <= '0';
						ELSIF(estado = 2) THEN
							--ERRO
							erro <= '1';
						ELSE
							--ERRO
							erro <= '1';
						END IF;
					ELSIF(mensagem(i*2) = '0' AND mensagem((i*2)+1) = '1') THEN
						IF(estado = 0) THEN
							--ERRO
							erro <= '1';
						ELSIF(estado = 1) THEN
							--ERRO
							erro <= '1';
						ELSIF(estado = 2) THEN
							mensagemDecodificada(i) <= '1';
							estado := 3;
							erro <= '0';
						ELSE
							mensagemDecodificada(i) <= '0';
							estado := 1;
							erro <= '0';
						END IF;
					ELSIF(mensagem(i*2) = '1' AND mensagem((i*2)+1) = '0') THEN
						IF(estado = 0) THEN
							--ERRO
							erro <= '1';
						ELSIF(estado = 1) THEN
							--ERRO
							erro <= '1';
						ELSIF(estado = 2) THEN
							mensagemDecodificada(i) <= '0';
							estado := 1;	
							erro <= '0';
						ELSE
							mensagemDecodificada(i) <= '1';
							estado := 3;
							erro <= '0';
						END IF;
					ELSIF(mensagem(i*2) = '1' AND mensagem((i*2)+1) = '1') THEN
						IF(estado = 0) THEN
							mensagemDecodificada(i) <= '1';
							estado := 2;
							erro <= '0';
						ELSIF(estado = 1) THEN
							mensagemDecodificada(i) <= '0';
							estado := 0;
							erro <= '0';
						ELSIF(estado = 2) THEN
							--ERRO
							erro <= '1';
						ELSE
							--ERRO
							erro <= '1';
						END IF;
					END IF;
				END LOOP;
				decodificada <= '1';
				mensagemAntiga := mensagemDecodificada;
			END IF;		
			
			IF(mensagemAntiga /= mensagemDecodificada) THEN
				decodificada <= '0';
				estado     := 0;
				--mensagemDecodificada <= "0000";
			END IF;				
		END IF;
	END PROCESS;
	
	saidamsgdecodificada <= mensagemDecodificada;
	
END main;
