library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd is
    port (
        data_out : out std_logic_vector(7 downto 0) := "00000000";
        RS : out std_logic; -- Chân RS của LCD (Register Select)
        RW : out std_logic := '0'; -- Chân RW của LCD (đọc ghi dữ liệu)
        EN : out std_logic := '1'; -- Chân kích hoạt LCD
        clk : in std_logic;
		  pwm_chuc: in std_logic_vector(3 downto 0);
		  pwm_don_vi: in std_logic_vector(3 downto 0)
    );
end lcd;

architecture ACT of lcd is
    type state is (delay, data_send);
    signal st : state := delay;
    type lcd_light is array (0 to 9) of std_logic_vector(7 downto 0);
    signal count : integer range 0 to 11 := 0;
    signal command : integer range 0 to 8 := 0;
    signal lcd_light_data : lcd_light := (x"44", x"4F", x"53", x"41", x"4E", x"47", x"3A", x"30", x"30", x"25"); -- DOSANG:00%

begin
    process (clk)
	 variable index : integer range 0 to 10 := 0;
    begin
		  lcd_light_data(7) <= "0011" & pwm_chuc;
		  lcd_light_data(8) <= "0011" & pwm_don_vi;
        if (rising_edge(clk)) then
            case st is
                when delay =>
                    count <= count + 1;
                    if (count = 5) then 
                        EN <= '0'; -- High to low để ghi
                    elsif (count = 10) then
                        EN <= '1'; -- Đưa xung về 1
                        count <= 0;
                        st <= data_send;
                    end if;
                when data_send =>
                    case command is
                        when 0 to 2 =>    -- Đợi lên nguồn
                            RS <= '0';
                            command <= command + 1;
                            st <= delay;
                        when 3 =>
                            data_out <= x"01";  -- 0x01 xóa màn hình
                            RS <= '0';
                            command <= command + 1;
                            st <= delay;
                        when 4 =>
                            data_out <= x"38";  -- 0x38 2 hàng, 5x7
                            RS <= '0';
                            command <= command + 1;
                            st <= delay;
                        when 5 =>
                            data_out <= x"0C";  -- 0x0C bật hiển thị, tắt con trỏ
                            RS <= '0';
                            command <= command + 1;
                            st <= delay;
                        when 6 => 
                            data_out <= x"80";  -- 0x80: đưa con trỏ về đầu dòng 1
                            RS <= '0';
                            command <= command + 1;
                            st <= delay;
                        when 7 =>
                            if (index < 10) then
                                data_out <= lcd_light_data(index);
                                RS <= '1';  -- Gửi dữ liệu lên LCD
                                index := index + 1;
                                st <= delay;
                            else
                                index := 0;
                                command <= command + 1;
                                st <= delay;
                            end if;
                        when 8 =>
                            data_out <= x"02";  -- 0x02: return home
                            RS <= '0';
                            command <= 7;
                            st <= delay;
                        when others =>
                            data_out <= x"00";
                    end case;
            end case;
        end if;    
    end process;
end ACT;
