vlib work

vcom -93 ../src/ALU.vhd
vcom -93 ../src/BancRegistre.vhd
vcom -93 ../src/UnitTraitement.vhd
vcom -93 UnitTraitement_tb.vhd

vsim -novopt UnitTraitement_tb

view signals
add wave *
add wave -position insertpoint -radix decimal sim:/unittraitement_tb/UUT/U1/Banc
run -all