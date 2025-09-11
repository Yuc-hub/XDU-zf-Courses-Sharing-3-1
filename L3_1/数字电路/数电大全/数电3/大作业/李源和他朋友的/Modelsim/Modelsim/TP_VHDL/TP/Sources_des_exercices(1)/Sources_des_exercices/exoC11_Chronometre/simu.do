##changement de r�pertoire par d�faut
##cr�ation de la library de travail, �cras� si existe deja
#vlib work
##compilation -93 : type de vhdl, -work my_lib : library avec r�sultat de compilation 
#vcom -93 -work work fsm.vhd
#vcom -93 -work work fsmtb.vhd
#
#
#
## vsim -lib work toto
## toto est soit le nom de l entity du testbench soit le nom de la configuration
## et non pas le nom du fichier qui contient ces noms
## une convention pratique est cependant de leur donner le meme nom
#
#vsim fsmtb
#view signals
#view structure
#add wave *
#run -all


# Auteur: Yuan Li
# Numero: 19022100022
# Date: 11/avril/2022

vlib work

# compiler
vcom -2008 fsm.vhd
vcom -2008 fsmtb.vhd

# simuler
vsim fsmtb
add wave *

run -all