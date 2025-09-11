vlib work

vcom -2008 MUX81.vhd
vcom -2008 MUX81_tb.vhd

vsim MUX81_tb

add wave *
run -all

