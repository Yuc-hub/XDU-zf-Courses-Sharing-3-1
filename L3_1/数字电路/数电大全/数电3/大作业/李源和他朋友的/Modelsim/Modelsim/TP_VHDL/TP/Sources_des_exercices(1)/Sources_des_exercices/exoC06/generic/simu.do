
vlib work

vcom -2008 ramchip.vhd
vcom -2008 board.vhd
vcom -2008 board_tb.vhd

vsim board_tb
add wave *
run 200000 ps
