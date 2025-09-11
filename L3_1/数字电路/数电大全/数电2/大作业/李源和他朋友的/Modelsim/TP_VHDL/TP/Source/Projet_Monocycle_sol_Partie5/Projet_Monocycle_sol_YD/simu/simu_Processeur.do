vlib work

vcom -93 ../src/ALU.vhd
vcom -93 ../src/BancRegistre.vhd
vcom -93 ../src/Registre.vhd
vcom -93 ../src/UnitTraitement.vhd
vcom -93 ../src/MUX2V1.vhd
vcom -93 ../src/Extension.vhd
vcom -93 ../src/DataMemory.vhd
vcom -93 ../src/decodeur.vhd
vcom -93 ../src/instruction_memory2.vhd
vcom -93 ../src/UdGInstruction.vhd
vcom -93 ../src/AssemblageUdT_final.vhd
vcom -93 ../src/Processeur.vhd
vcom -93 Processeur_tb.vhd

#vsim -novopt Processeur_tb
vsim Processeur_tb
view signals
add wave *

add wave  -radix unsigned sim:/processeur_tb/UUT/U2/PC
add wave  -radix decimal sim:/processeur_tb/UUT/U2/Offset_s
add wave  -radix hexadecimal sim:/processeur_tb/UUT/U2/Instruction
add wave  -radix hexadecimal sim:/processeur_tb/UUT/U3/*
add wave  -radix hexadecimal sim:/processeur_tb/UUT/U1/U1/Banc
add wave -position insertpoint -radix decimal sim:/processeur_tb/UUT/U1/U6/mem


run -all