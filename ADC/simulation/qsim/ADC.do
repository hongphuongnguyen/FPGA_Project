onerror {exit -code 1}
vlib work
vlog -work work main.vo
vlog -work work Waveform.vwf.vt
vsim -novopt -c -t 1ps -L maxii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.div_clk_vlg_vec_tst -voptargs="+acc"
vcd file -direction ADC.msim.vcd
vcd add -internal div_clk_vlg_vec_tst/*
vcd add -internal div_clk_vlg_vec_tst/i1/*
run -all
quit -f
