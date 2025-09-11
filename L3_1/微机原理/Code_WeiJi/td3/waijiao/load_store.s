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

start:
								@ Instructions de tranfert sur mot, demi mot, octet, signe/non signe 
		ADR 	R1, EX_1
		LDR		R3, [R1]
		LDRH	R3, [R1]
		LDRSH	R3, [R1]
		LDRB	R3, [R1]
		LDRSB	R3, [R1]
								@ Modes d adressage 
		ADR 	R1, EX_2
		LDR		R3, [R1]		@ adressage indirect par registre
		MOV		R2, #4
		LDR		R3, [R1, R2]	@ adressage indexe
		ADR 	R1, EX_3
		LDR		R3, [R1, R2]!	@ adressage pre-indexe automatique
		ADR 	R1, EX_3
		LDR		R3, [R1], R2	@ adressage post indexe automatique
		
								@ Instructions de tranferts mulitiples 
								@ SANS mise a jour du registre de base
		ADR 	R1, EX_3		
		LDMIA 	R1, {R3, R5-R7, R9}
		LDMIB 	R1, {R3, R5-R7, R9}
		LDMDA 	R1, {R3, R5-R7, R9}
		LDMDB 	R1, {R3, R5-R7, R9}
								@ Instructions de transferts mulitiples 
								@ AVEC mise a jour du registre de base
		LDMIA 	R1!, {R3, R5-R7, R9}
		ADR 	R1, EX_3
		LDMIB 	R1!, {R3, R5-R7, R9}
		ADR 	R1, EX_3
		LDMDA 	R1!, {R3, R5-R7, R9}
		ADR 	R1, EX_3
		LDMDB 	R1!, {R3, R5-R7, R9}
		
								@ Pour finir, on bloque le processeur dans une boucle infinie vide
wait:		b 		wait
  
 
  
 
