
vlib work
vcom -93 Mux2_1.vhd
vcom -93 tb_Mux2_1.vhd

vsim tb_Mux2_1

add wave -decimal *
run -all
