library ieee;
use ieee.std_logic_1164.all;

entity main is 
port( 
	BUFFER_ADC : in std_logic_vector(7 downto 0);    -- Sử dụng cho ADC
   CLK_IN, EOC : in std_logic;             
   CLK_OUT, START, OE : out std_logic;         		
   PWM_OUT : out std_logic;
   LED: out std_logic;
   LCD_RS, LCD_RW, LCD_E: out std_logic;
   LCD_DATA: out std_logic_vector(7 downto 0)
);
end main;

architecture LogicFunction of main is
   signal CLK_TEMP : std_logic := '0';
	signal HANG_CHUC: std_logic_vector(3 downto 0);
	signal HANG_DONVI: std_logic_vector(3 downto 0);
begin    
   -- Khối chia tần số để tạo xung nhịp cho ADC0804
   U0: entity work.div_clk
      port map(
         clk_in => CLK_IN, 
         clk_out => CLK_TEMP
		); 

   -- Khối đọc giá trị từ ADC0804 và điều khiển xung PWM
   U1: entity work.adc
      port map(
         clk => CLK_TEMP, 
         start => START, 
         oe => OE, 
         data_adc_out => BUFFER_ADC, 
         eoc => EOC, 
			led => LED
      );

   -- Khối PWM sử dụng giá trị từ ADC để điều khiển xung PWM
   U2: entity work.pwm
      port map (
         clk => CLK_IN, 
         data_pwm_in =>  BUFFER_ADC, 
         pwm_out => PWM_OUT,
			hang_chuc => HANG_CHUC,
			hang_don_vi => HANG_DONVI
      );
		  
	 U3: entity work.lcd
		 port map(
			clk => CLK_IN,
			RW => LCD_RW,
			RS => LCD_RS,
			EN => LCD_E,
			data_out => LCD_DATA,
			pwm_chuc => HANG_CHUC,
			pwm_don_vi => HANG_DONVI
		);

    -- Kết nối tín hiệu xung nhịp cho ADC0804
    CLK_OUT <= CLK_TEMP;
end LogicFunction;
