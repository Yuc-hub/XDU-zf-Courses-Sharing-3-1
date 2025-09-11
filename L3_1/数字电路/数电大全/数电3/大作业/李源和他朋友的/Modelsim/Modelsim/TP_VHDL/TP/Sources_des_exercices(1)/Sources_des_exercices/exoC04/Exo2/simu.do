#vlib work
#
#
#vcom -93 mux81.vhd
#vcom -93 mux81_tb.vhd
#
#vsim -novopt mux81_tb
#
#view signals
#add wave *
#run -all
#

vlib work

vcom -2008 serialor.vhd
vcom -2008 serialor_tb.vhd

vsim serialor_tb(TB1)

#view signals
#add wave /UUT/* 
add wave *
run -all
