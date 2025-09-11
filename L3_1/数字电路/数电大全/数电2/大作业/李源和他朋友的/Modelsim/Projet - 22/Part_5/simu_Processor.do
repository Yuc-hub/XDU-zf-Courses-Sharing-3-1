vlib work

vcom -2008 ALU.vhd
vcom -2008 RegisterBank.vhd
vcom -2008 Registre.vhd
vcom -2008 SimpleTreatU.vhd
vcom -2008 MUX2to1.vhd
vcom -2008 Extender.vhd
vcom -2008 DataMemory.vhd
vcom -2008 Decoder.vhd
vcom -2008 instruction_memory2.vhd
vcom -2008 InstructionU.vhd
vcom -2008 FinalTreatU.vhd
vcom -2008 Processor.vhd
vcom -2008 Processor_tb.vhd

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