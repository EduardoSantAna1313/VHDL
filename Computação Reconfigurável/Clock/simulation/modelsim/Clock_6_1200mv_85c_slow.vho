-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 15.0.0 Build 145 04/22/2015 SJ Web Edition"

-- DATE "12/02/2016 11:33:25"

-- 
-- Device: Altera EP4CE22F17C6 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Clock IS
    PORT (
	clockplaca : IN std_logic;
	clk : OUT std_logic
	);
END Clock;

-- Design Ports Information
-- clk	=>  Location: PIN_J2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clockplaca	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Clock IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clockplaca : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL \clockplaca~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk~output_o\ : std_logic;
SIGNAL \clockplaca~input_o\ : std_logic;
SIGNAL \clockplaca~inputclkctrl_outclk\ : std_logic;
SIGNAL \indice[0]~2_combout\ : std_logic;
SIGNAL \indice[1]~0_combout\ : std_logic;
SIGNAL \indice[2]~1_combout\ : std_logic;
SIGNAL \x~0_combout\ : std_logic;
SIGNAL indice : std_logic_vector(2 DOWNTO 0);

BEGIN

ww_clockplaca <= clockplaca;
clk <= ww_clk;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clockplaca~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clockplaca~input_o\);

-- Location: IOOBUF_X0_Y15_N2
\clk~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \x~0_combout\,
	devoe => ww_devoe,
	o => \clk~output_o\);

-- Location: IOIBUF_X0_Y16_N8
\clockplaca~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clockplaca,
	o => \clockplaca~input_o\);

-- Location: CLKCTRL_G2
\clockplaca~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clockplaca~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clockplaca~inputclkctrl_outclk\);

-- Location: LCCOMB_X1_Y16_N28
\indice[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \indice[0]~2_combout\ = !indice(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => indice(0),
	combout => \indice[0]~2_combout\);

-- Location: FF_X1_Y16_N29
\indice[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clockplaca~inputclkctrl_outclk\,
	d => \indice[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => indice(0));

-- Location: LCCOMB_X1_Y16_N12
\indice[1]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \indice[1]~0_combout\ = indice(1) $ (indice(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => indice(1),
	datad => indice(0),
	combout => \indice[1]~0_combout\);

-- Location: FF_X1_Y16_N13
\indice[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clockplaca~inputclkctrl_outclk\,
	d => \indice[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => indice(1));

-- Location: LCCOMB_X1_Y16_N18
\indice[2]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \indice[2]~1_combout\ = indice(2) $ (((indice(0) & indice(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => indice(0),
	datac => indice(2),
	datad => indice(1),
	combout => \indice[2]~1_combout\);

-- Location: FF_X1_Y16_N19
\indice[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clockplaca~inputclkctrl_outclk\,
	d => \indice[2]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => indice(2));

-- Location: LCCOMB_X1_Y16_N30
\x~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \x~0_combout\ = \clockplaca~input_o\ $ (((indice(1) & (indice(0) & !indice(2))) # (!indice(1) & ((indice(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => indice(1),
	datab => indice(0),
	datac => \clockplaca~input_o\,
	datad => indice(2),
	combout => \x~0_combout\);

ww_clk <= \clk~output_o\;
END structure;


