vlib work

vcom -93 ../src/ALU.vhd
vcom -93 ../src/BancRegistre.vhd
vcom -93 ../src/UnitTraitement.vhd
vcom -93 ../src/MUX2V1.vhd
vcom -93 ../src/Extension.vhd
vcom -93 ../src/DataMemory.vhd
vcom -93 ../src/AssemblageUdT.vhd
vcom -93 AssemblageUdT_tb.vhd

vsim -novopt AssemblageUdT_tb

view signals
add wave *
add wave -position insertpoint -radix decimal sim:/assemblageudt_tb/UUT/U6/mem
add wave -position insertpoint -radix decimal sim:/assemblageudt_tb/UUT/U1/Banc
run -all