
vlib work
vcom -93 UAL.vhd
vcom -93 tb_UAL.vhd

vsim tb_UAL

add wave -decimal *
run -all
