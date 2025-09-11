
vlib work

vcom -2008 decoder.vhd
vcom -2008 decoder_tb.vhd

vsim decoder_tb(bench)

add wave *

run -all