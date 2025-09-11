@ Fichier td4_ex1_1b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td4_ex1_1b.o td4_ex1_1b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td4_ex1_1b.elf td4_ex1_1b.o
@ arm-elf-insight td4_ex1_1b.elf

							@ directives de compilation --------------------------
	.text
	.align 4

	.global start
	
							@ Section de données --------------------------
C:		.word		0			 

start:
		foo: 	
		STMFD	SP!, {R8, LR}
		MOV		R8, #4
		ADD		R1, R8, R4
		BL		bar
		LDMFD 	SP!, {R8, LR}
		MOV 		PC,LR

bar: 			STMFD		SP!, {R1,R8} @on empile R1 et R8 @sauvegarde du context

		MOV		R8, R4
		ADD 	R8, R8, R1
		MOV 	R1, R8
		LDMFD 	SP!, {R1, R8}
		MOV		PC, LR

		
		
