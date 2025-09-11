@ Fichier td52.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td52.o td52.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td52.elf td52.o
@ arm-elf-insight td52.elf

								@ directives de compilation --------------------------
		.text
		.align 	4

		.global start
	
								@ Section de données --------------------------
A: 		.word	3
B: 		.word	7
C: 		.word	1
TEST:	.word	0

start:
		@ passage des parametres
		LDR		R0, A			@ passage des parametres A, B, C par la pile
		STR 	R0, [SP, #-4]! 
		LDR		R0, B			
		STR 	R0, [SP, #-4]! 
		LDR		R0, C			
		STR 	R0, [SP, #-4]! 
		BL		TEST_CUBE
		STR		R0, TEST	@enregistre le résultat dans la case mémoire TEST
		
wait:	B		wait


TEST_CUBE:	
		STMFD	SP!, {R1, R2, R3, R4, LR} @enregistre contexte
		MOV		R0, #0
		LDR		R1, [SP, #28]	@ lecture des parametres A, B, C dans la pile
		LDR		R2, [SP, #24]
		LDR		R3, [SP, #20]
		BL		VALEUR_NOMBRE  @passage des paramètres A,B et C par registres (R1, R2, R3)
		MOV		R4, R0		   @enregistre "A*100 + B*10 + C"  dans R4	
		BL		SOMME_CUBE
		CMP		R4, R0		  @compare R0 et R4 donc "R1^3 + R2^3 + R3^3" et "A*100 + B*10 + C"
		MOVEQ	R0, #1		  @si ils sont égaux R0=1
		LDMFD	SP!, {R1, R2, R3, R4, LR} @ restitue le contexte et récupère @ retour
		ADD		SP, SP, #12				  @ libère les paramètres A, B et C de la pile
		MOV		PC, LR

VALEUR_NOMBRE: 	
		STMFD	SP!, {LR}			@ enregistrement @retour
		MOV		R0, R1, LSL#6		@ R0 <- A*64
		ADD		R0, R0, R1, LSL#5	@ R0 <- A*96 (R0=A*64 + A*32)
		ADD		R0, R0, R1, LSL#2	@ R0 <- A*100 (R0=A*64 + A*32 + A*4)
		ADD		R0, R0, R2, LSL#3	@ R0 <- A*100 + B*8
		ADD		R0, R0, R2, LSL#1	@ R0 <- A*100 + B*10
		ADD		R0, R0, R3			@ R0 <- A*100 + B*10 + C
		@MOV 		R5, #100
		@MUL			R0, R1, R5			@ R0 <- A*100
		@MOV 		R5, #10
		@MUL			R6, R2, R5			@ R6 <- B*10
		@ADD 		R0, R0, R6			@ R0 <- A*100 + B*10
		@ADD			R0, R0, R3			@ R0 <- A*100 + B*10 + C
		LDMFD	SP!, {LR}			@ dépile @retour
		MOV		PC, LR

SOMME_CUBE: 
		STMFD	SP!, {R6, R7, LR}   @enregistre contexte
		MUL		R6, R1, R1			@ R6 <- R1^2
		MUL		R0, R6, R1			@ R0 <- R1^3
		MUL		R6, R2, R2			@ R6 <- R2^2
		MUL		R7, R6, R2			@ R7 <- R2^3
		ADD		R0, R0, R7			@ R0 <- R1^3 + R2^3
		MUL		R6, R3, R3			@ R7 <- R3^2
		MUL		R7, R6, R3			@ R7 <- R3^3
		ADD		R0, R0, R7			@ R0 <- R1^3 + R2^3 + R3^3
		LDMFD	SP!, {R6, R7, LR}   @ restitue le contexte et récupère @ retour
		MOV		PC, LR

