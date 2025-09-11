vlib work 

vcom -93 mux21.vhd

#vsim mux21(dataflow)
vsim mux21

view signals 
add wave *

force -freeze sim:/mux21/A 1 0, 0 {50 ps} -r 100
force -freeze sim:/mux21/B 1 0, 0 {100 ps} -r 200
force -freeze sim:/mux21/SEl 1 0, 0 {200 ps} -r 400

run 500 ns