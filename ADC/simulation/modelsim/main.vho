-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "06/10/2024 18:47:54"

-- 
-- Device: Altera EPM240T100C5 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY IEEE;
LIBRARY MAXII;
USE IEEE.STD_LOGIC_1164.ALL;
USE MAXII.MAXII_COMPONENTS.ALL;

ENTITY 	div_clk IS
    PORT (
	clk_in : IN std_logic;
	clk_out : BUFFER std_logic
	);
END div_clk;

-- Design Ports Information
-- clk_out	=>  Location: PIN_61,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- clk_in	=>  Location: PIN_14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF div_clk IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk_in : std_logic;
SIGNAL ww_clk_out : std_logic;
SIGNAL \clk_in~combout\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL \temp~regout\ : std_logic;
SIGNAL count : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_clk_in <= clk_in;
clk_out <= ww_clk_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: PIN_14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk_in~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_clk_in,
	combout => \clk_in~combout\);

-- Location: LC_X7_Y2_N1
\count[0]\ : maxii_lcell
-- Equation(s):
-- count(0) = DFFEAS(((!count(0) & ((!count(2)) # (!count(3))))), GLOBAL(\clk_in~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "050f",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => count(3),
	datac => count(0),
	datad => count(2),
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => count(0));

-- Location: LC_X7_Y2_N7
\count[1]\ : maxii_lcell
-- Equation(s):
-- count(1) = DFFEAS((count(2) & (!count(3) & (count(1) $ (count(0))))) # (!count(2) & (count(1) $ ((count(0))))), GLOBAL(\clk_in~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "143c",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => count(2),
	datab => count(1),
	datac => count(0),
	datad => count(3),
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => count(1));

-- Location: LC_X7_Y2_N8
\count[2]\ : maxii_lcell
-- Equation(s):
-- count(2) = DFFEAS((count(2) & (!count(3) & ((!count(0)) # (!count(1))))) # (!count(2) & (count(1) & (count(0)))), GLOBAL(\clk_in~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "406a",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => count(2),
	datab => count(1),
	datac => count(0),
	datad => count(3),
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => count(2));

-- Location: LC_X7_Y2_N6
\count[3]\ : maxii_lcell
-- Equation(s):
-- count(3) = DFFEAS((count(2) & (count(0) & (count(1) & !count(3)))) # (!count(2) & (((count(3))))), GLOBAL(\clk_in~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5580",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	dataa => count(2),
	datab => count(0),
	datac => count(1),
	datad => count(3),
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => count(3));

-- Location: LC_X7_Y2_N3
\LessThan0~0\ : maxii_lcell
-- Equation(s):
-- \LessThan0~0_combout\ = (((count(0) & count(1))) # (!count(2))) # (!count(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "d5ff",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => count(3),
	datab => count(0),
	datac => count(1),
	datad => count(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \LessThan0~0_combout\);

-- Location: LC_X7_Y2_N4
temp : maxii_lcell
-- Equation(s):
-- \temp~regout\ = DFFEAS(((\temp~regout\ $ (!\LessThan0~0_combout\))), GLOBAL(\clk_in~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f00f",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk_in~combout\,
	datac => \temp~regout\,
	datad => \LessThan0~0_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \temp~regout\);

-- Location: PIN_61,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\clk_out~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \temp~regout\,
	oe => VCC,
	padio => ww_clk_out);
END structure;


