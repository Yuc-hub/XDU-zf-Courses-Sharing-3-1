vlib work

vcom -2008 ALU.vhd
vcom -2008 RegisterBank.vhd
vcom -2008 SimpleTreatU.vhd
vcom -2008 SimpleTreatU_tb.vhd

#vsim -novopt SimpleTreatU_tb
vsim SimpleTreatU_tb
view signals
add wave *
add wave -position insertpoint -radix hexadecimal sim:/simpletreatu_tb/UUT/U1/Banc

run -all