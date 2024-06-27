library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity div_clk is
port(
	clk_in: in std_logic; -- 5Mhz
	clk_out: out std_logic
);
end div_clk;

architecture LogicFunction of div_clk is
	signal temp: std_logic := '0';
begin	
	process(clk_in)
		variable count : integer range 0 to 21 := 0;
	begin
		if rising_edge(clk_in) then
			count := count + 1;
			if count >= 10 then  -- Tần số 500KHz
				temp <= not temp;
				count := 0;
			end if;
		end if;
	end process;
	clk_out <= temp;
end LogicFunction;
