library verilog;
use verilog.vl_types.all;
entity div_clk is
    port(
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic
    );
end div_clk;
