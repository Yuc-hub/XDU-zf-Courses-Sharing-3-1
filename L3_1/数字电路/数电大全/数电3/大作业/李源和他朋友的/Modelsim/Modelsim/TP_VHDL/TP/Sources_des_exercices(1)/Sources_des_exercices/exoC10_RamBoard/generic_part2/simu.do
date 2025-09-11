# Auteur: Yuan Li
# Numero: 19022100022
# Date: 11/avril/2022

vlib work

# compiler
vcom -2008 ramchip.vhd
vcom -2008 board.vhd
vcom -2008 board_tb.vhd

# simuler
vsim board_tb
add wave *

run 4000 ns
