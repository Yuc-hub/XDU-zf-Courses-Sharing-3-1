#changement de répertoire par défaut
#cd C:/Train/CVHDL/ex6/
#création de la library de travail, écrasé si existe deja
vlib work
#compilation -93 : type de vhdl, -work my_lib : library avec résultat de compilation 
vcom -2008 ramchip.vhd
vcom -2008 ramchip_tb.vhd
#vcom -93 -work work fsmcf.vhd


# vsim -lib work toto
# toto est soit le nom de l entity du testbench soit le nom de la configuration
# et non pas le nom du fichier qui contient ces noms
# une convention pratique est cependant de leur donner le meme nom

vsim ramchip_tb

#view signals
#view structure
#add wave nCS
#add wave nOE
#add wave nWE
#add wave -radix unsigned Address
#add wave -radix hexadecimal Data
#add wave -radix hexadecimal /UUT/mem


add wave *
run -all