

vlib work
vcom -93 UC.vhd
vcom -93 tb_UC.vhd

vsim tb_UC

add wave -hexa *
add wave /uut/decode_instruction/immediate
add wave -hexa /uut/decode_instruction/offset
run -all