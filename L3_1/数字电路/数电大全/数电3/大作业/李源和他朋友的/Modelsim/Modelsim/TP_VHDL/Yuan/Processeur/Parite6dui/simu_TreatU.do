vlib work

vcom -2008 ALU.vhd
vcom -2008 RegisterBank.vhd
vcom -2008 SimpleTreatU.vhd
vcom -2008 MUX2to1.vhd
vcom -2008 Extender.vhd
vcom -2008 Datamemory.vhd
vcom -2008 TreatU.vhd
vcom -2008 TreatU_tb.vhd

#vsim -novopt TreatU_tb
vsim TreatU_tb
view signals
add wave *
add wave -position insertpoint -radix decimal sim:/TreatU_tb/UUT/U1/Banc
#add wave -radix decimal {sim:/TreatU_tb/UUT/U1/Banc }

run -all