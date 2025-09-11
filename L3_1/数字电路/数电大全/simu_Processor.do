vlib work

vcom -2008 ../src/ALU.vhd
vcom -2008 ../src/RegisterBank.vhd
vcom -2008 ../src/Registre.vhd
vcom -2008 ../src/MUX2to1.vhd
vcom -2008 ../src/Extender.vhd
vcom -2008 ../src/DataMemory.vhd
vcom -2008 ../src/Decoder.vhd
vcom -2008 ../src/instruction_memory.vhd
vcom -2008 ../src/InstructionU.vhd
vcom -2008 ../src/RegisterAff.vhd
vcom -2008 ../src/FinalTreatU.vhd
vcom -2008 ../src/Processor.vhd
vcom -2008 ../simu/Processor_tb.vhd

vsim Processor_tb
view signals
add wave *

add wave  -radix unsigned sim:/Processor_tb/UUT/U2/PC
add wave  -radix decimal sim:/Processor_tb/UUT/U2/Offset_s
add wave  -radix hexadecimal sim:/Processor_tb/UUT/U2/Instruction
add wave  -radix hexadecimal sim:/Processor_tb/UUT/U3/*
add wave  -radix hexadecimal sim:/Processor_tb/UUT/U1/U1/Banc
add wave -position insertpoint -radix decimal sim:/Processor_tb/UUT/U1/U6/mem


run -all