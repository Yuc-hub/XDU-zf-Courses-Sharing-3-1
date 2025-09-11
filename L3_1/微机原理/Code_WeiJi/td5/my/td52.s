@ Fichier td52.s
@ arm-elf-as -mcpu=arm7tdmi -g -o td52.o td52.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td52.elf td52.o
@ arm-elf-insight td52.elf

							@ directives de compilation --------------------------
	.text
	.align 4

	.global start
	
							@ Section de données --------------------------
A:		.word		3
B:		.word		7
C:		.word		1	 
TEST_RES:	.word		0
							@ Section de code --------------------------
start:
		LDR		R0, A
		STR		R0, [SP, #-4]!
		LDR		R0, B
		STR		R0, [SP, #-4]!
		LDR		R0, C
		STR		R0, [SP, #-4]!
		BL		TEST_CUBE
		STR		R0, TEST_RES

EXIT:		B		EXIT		


TEST_CUBE:		
			STMFD		SP!, {R1-R4, LR}
			LDR			R1, [SP, #28]
			LDR			R2, [SP, #24]
			LDR			R3, [SP, #20]
			BL			VALEUR_NOMBRE2
			MOV		R4, R0
			BL			SOMME_CUBE
			CMP		R0, R4
			MOV		R0, #0
			MOVEQ		R0, #1				
			LDMFD		SP!, {R1-R4, PC}
			
			
@VALEUR_NOMBRE1:		
@			STMFD		SP!, {R4, R5, LR}
@			MOV		R5, #100						
@			MUL			R0, R1, R5
@			MOV		R5, #10
@			MUL			R4, R2, R5
@			ADD		R0, R0, R4
@			ADD		R0, R0, R3
@			LDMFD		SP!, {R4, R5, PC}

VALEUR_NOMBRE2:	
			STMFD		SP!, {R4, LR}
			MOV		R0, R1, LSL #6					@ 100 = 64+32+4 = 2*6+2*5+2*2
			ADD		R0, R0, R1, LSL#5
			ADD		R0, R0, R1, LSL #2
			ADD		R0, R0, R2, LSL #3				@ 10 = 8+2 = 2*3+2*1	
			ADD		R0, R0, R2, LSL #1
			ADD		R0, R0, R3 						
			LDMFD		SP!, {R4, PC}
		
SOMME_CUBE:	
			STMFD		SP!, {R4, LR}
			MUL			R0, R1, R1
			MUL			R0, R1, R0
			MUL			R4, R2, R2
			MUL			R4, R2, R4
			ADD		R0, R0, R4
			MUL			R4, R3, R3
			MUL			R4, R3, R4
			ADD		R0, R0, R4
			LDMFD		SP!, {R4, PC}
			