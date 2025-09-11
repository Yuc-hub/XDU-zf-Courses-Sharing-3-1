vlib work

vcom -2008 ALU.vhd
vcom -2008 RegisterBank.vhd
vcom -2008 SimpleTreatU.vhd
vcom -2008 MUX2to1.vhd
vcom -2008 Extender.vhd
vcom -2008 Datamemory.vhd
vcom -2008 FinalTreatU.vhd
vcom -2008 FinalTreatU_tb.vhd

vsim -novopt FinalTreatU_tb
#vsim FinalTreatU_tb

view signals
add wave *
#add wave -position insertpoint -radix decimal sim:/FinalTreatU_tb/UUT/U1/Banc
add wave -radix decimal {sim:/FinalTreatU_tb/UUT/U1/Banc }

run -all