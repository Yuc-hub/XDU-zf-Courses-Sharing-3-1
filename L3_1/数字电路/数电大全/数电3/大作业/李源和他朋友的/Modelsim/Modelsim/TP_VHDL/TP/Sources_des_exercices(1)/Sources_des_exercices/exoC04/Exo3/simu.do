vlib work

# compiler
vcom -2008 minmax.vhd
vcom -2008 minmax_tb.vhd

# simuler
vsim minmax_tb
add wave *
run -all