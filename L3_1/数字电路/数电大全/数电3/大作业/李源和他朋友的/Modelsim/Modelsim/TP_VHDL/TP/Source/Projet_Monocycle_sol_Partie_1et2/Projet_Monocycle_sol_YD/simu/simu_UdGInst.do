vlib work

vcom -93 ../src/Extension.vhd
vcom -93 ../src/instruction_memory.vhd
vcom -93 ../src/UdGInstruction.vhd
vcom -93 UdGInstruction_tb.vhd

vsim -novopt UdGInstruction_tb

view signals
add wave *
add wave -position insertpoint  -radix hexadecimal sim:/udginstruction_tb/UUT/PC

run -all