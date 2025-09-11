@ Fichier load_store.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o load_store.o load_store.s
@ arm-elf-ld -Ttext=0x8000 -e start -o load_store.elf load_store.o
@ arm-elf-insight load_store.elf   
								@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

								@ Section de données --------------------------
EX_1: 	.word		0xFFEEFDFC
EX_2:	.word		1, 2, 3, 4, 5, 6
EX_3:	.word		7, 8, 9, 10, 11, 12

								@ Section de code --------------------------

start:								@ recopier les valeurs de EX2 dans le EX3
		ADR	r0, EX_2
		ADR	r7, EX_3
		LDMIA	r0 , {r1-r6}
		STMIA	r7, {r1-r6}
	

wait:		b 		wait
  
 
  
 
