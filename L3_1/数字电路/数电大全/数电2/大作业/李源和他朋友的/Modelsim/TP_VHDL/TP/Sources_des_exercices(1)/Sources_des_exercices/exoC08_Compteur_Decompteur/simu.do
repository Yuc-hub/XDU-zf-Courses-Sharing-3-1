# auteur: Yuan Li
# numero: 19022100022

vlib work


# compiler
vcom -2008 counter.vhd
vcom -2008 counter_tb.vhd


# simuler
vsim counter_tb(Bench)



# des waves
view signals
add wave *

run -all