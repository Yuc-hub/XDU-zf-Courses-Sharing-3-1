# création de la librairie de travail work
vlib work

#compilation des fichiers vhdl, l'ordre de compilation est important
#commencer par le package, les composants, le top-level et enfin 
# le test-bench 
#vcom -93 packages.vhd
#vcom -93 sources.vhd
#vcom -93 testbench.vhd
#Exemple :

vcom -2008 mux81.vhd
vcom -2008 mux81_tb.vhd


#lancer la simulation avec le nom du testbench (si il existe)
#sinon avec le nom du top-level design
#pour chacun des cas précisez le nom de l'entité, pas le nom du fichier

vsim -novopt mux81_tb

#entre paranthèse vous pouvez préciser le nom de l’architecture 

#pour visualiser tout les signaux du design:

view signals
add wave *

#lancer la simulation
run -all
