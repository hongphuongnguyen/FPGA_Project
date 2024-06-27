library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
    port (
        clk : in std_logic;
        data_pwm_in : in std_logic_vector(7 downto 0); -- giá trị đọc từ ADC
        pwm_out : out std_logic;
        hang_chuc : out std_logic_vector(3 downto 0); -- hàng chục của giá trị duty cycle mapped
        hang_don_vi : out std_logic_vector(3 downto 0) -- hàng đơn vị của giá trị duty cycle mapped
    );
end pwm;

architecture logic_function of pwm is
    signal duty_cycle_raw : integer range 0 to 255 := 0; -- giá trị duty cycle từ 0 đến 255
    --signal duty_cycle_mapped : integer range 0 to 100 := 0; -- giá trị duty cycle đã map từ 0 đến 100
    signal chuc : integer range 0 to 9 := 1; -- hàng chục của giá trị duty cycle mapped
    signal don_vi : integer range 0 to 9 := 7; -- hàng đơn vị của giá trị duty cycle mapped
begin
    -- Quá trình tính toán và cập nhật giá trị duty cycle
    process (clk)
        variable pwm_counter : integer range 0 to 300 := 0;
    begin
        if rising_edge(clk) then
            pwm_counter := pwm_counter + 1;
            if pwm_counter < duty_cycle_raw then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
            if pwm_counter >= 255 then
                pwm_counter := 0;
            end if;
				
				 -- Cập nhật duty_cycle_raw từ data_pwm_in
            duty_cycle_raw <= to_integer(unsigned(data_pwm_in));
            
				if duty_cycle_raw < 20 then 
					chuc <= 9;
					don_vi <= 9;
				elsif duty_cycle_raw >= 20 and duty_cycle_raw < 40 then 
					chuc <= 9;
					don_vi <= 0;
				elsif duty_cycle_raw >= 40 and duty_cycle_raw < 70 then 
					chuc <= 8;
					don_vi <= 0;
				elsif duty_cycle_raw >= 70 and duty_cycle_raw < 100 then 
					chuc <= 7;
					don_vi <= 0;
				elsif duty_cycle_raw >= 100 and duty_cycle_raw < 120 then 
					chuc <= 6;
					don_vi <= 0;
				elsif duty_cycle_raw >= 140 and duty_cycle_raw < 160 then 
					chuc <= 5;
					don_vi <= 0;
				elsif duty_cycle_raw >= 160 and duty_cycle_raw < 180 then 
					chuc <= 4;
					don_vi <= 0;
				elsif duty_cycle_raw >= 180 and duty_cycle_raw < 200 then 
					chuc <= 3;
					don_vi <= 0;
				elsif duty_cycle_raw >= 200 and duty_cycle_raw < 220 then 
					chuc <= 2;
					don_vi <= 0;
				elsif duty_cycle_raw >= 220 and duty_cycle_raw < 240 then 
					chuc <= 1;
					don_vi <= 0;
				elsif duty_cycle_raw >= 240 then 
					chuc <= 0;
					don_vi <= 5;
				end if;
					
				--duty_cycle_mapped <= duty_cycle_raw * 100 / 255;
				
            -- Tách hàng chục và hàng đơn vị của duty_cycle_mapped
            -- tens_digit <= duty_cycle_mapped / 10;
            --ones_digit <= (duty_cycle_mapped - (tens_digit * 10));
            
            -- Xuất giá trị hàng chục và hàng đơn vị ra ngoài
            hang_chuc <= std_logic_vector(to_unsigned(chuc, 4));
            hang_don_vi <= std_logic_vector(to_unsigned(don_vi, 4));
        end if;
    end process;
    
end logic_function;
