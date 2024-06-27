library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc is
port(
	clk : in std_logic;
	start : out std_logic;									-- WR
	oe : out std_logic;										-- RD
	data_adc_out: in std_logic_vector(7 downto 0);
	eoc: in std_logic;										-- INTR
	led : out std_logic := '0'
);
end adc;

architecture behav of adc is
	signal flag : std_logic := '0';
begin	
	process(clk)
		variable count: integer range 0 to 6000 := 0;
	begin
		if rising_edge(clk) then
			count := count + 1;
			if count = 1 then
				start <= '0';
			end if;
			if count = 3 then
				start <= '1';
				flag <= '1';
			end if;
			if (count > 3) and (eoc = '0') and (flag = '1') then
				oe <= '0';
				flag <= '0';
			end if;
			if count >= 5000 then
				oe <= '1';
				count := 0;
			if unsigned(data_adc_out) > 50 then
				led <= '1';
			else
				led <= '0';
			end if;
			
			end if;
		end if;
	end process;
end behav;
