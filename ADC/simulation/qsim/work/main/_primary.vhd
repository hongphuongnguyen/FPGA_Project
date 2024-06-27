library verilog;
use verilog.vl_types.all;
entity main is
    port(
        BUFFER_ADC      : in     vl_logic_vector(7 downto 0);
        CLK_IN          : in     vl_logic;
        EOC             : in     vl_logic;
        CLK_OUT         : out    vl_logic;
        START           : out    vl_logic;
        ALE             : out    vl_logic;
        OE              : out    vl_logic;
        PWM_OUT         : out    vl_logic;
        LED             : out    vl_logic
    );
end main;
