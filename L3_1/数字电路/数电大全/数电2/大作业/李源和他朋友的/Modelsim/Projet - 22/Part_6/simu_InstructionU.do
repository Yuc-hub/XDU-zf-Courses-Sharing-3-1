vlib work

vcom -2008 Extender.vhd
vcom -2008 instruction_memory.vhd
vcom -2008 InstructionU.vhd
vcom -2008 InstructionU_tb.vhd

vsim InstructionU_tb

view signals

add wave *

add wave -radix hexadecimal sim:/instructionu_tb/UUT/PC

run -all