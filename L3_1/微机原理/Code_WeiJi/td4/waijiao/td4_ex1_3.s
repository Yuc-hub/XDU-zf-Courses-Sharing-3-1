@ Fichier td4_ex1_3.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td4_ex1_3.o td4_ex1_3.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td4_ex1_3.elf td4_ex1_3.o
@ arm-elf-insight td4_ex1_3.elf

							@ directives de compilation --------------------------
	.text
	.align 4

	.global start
	
							@ Section de données --------------------------
TAB:		.word		0, 1, 2, 3, 4, 5, 6, 7, 8, 9			 

							@ Section de code --------------------------
start:
			ADR		R0, TAB		@ passage du parametre par le registre R0
			BL		SOMME_CARRE
			
wait:		b		wait

CARRE:		
			STMFD	SP!, {R1, LR}       @ sauvegarde contexte
			LDR		R1, [SP, #8]		@ lecture du parametre
			MUL		R0, R1, R1			@ R0=TAB[i]²
			LDMFD	SP!, {R1, LR}		@ restauration du contexte dont @ retour (LR)
			ADD		SP, SP, #4			@ libère la pile du parametre TAB[i]
			MOV		PC, LR

SOMME_CARRE:
			STMFD	SP!, {R0, LR}	@ on empile LR et R0 (sauvegarde contexte)
			MOV		R3, #0			@ R3=i=0
			MOV		R1, #0			@ resultat de la somme dans R1
			MOV		R4, R0			@ sauvegarde R0, car modifie par CARRE, donc R4=@TAB[0]
			
LOOP:		LDR		R2, [R4], #4	@ R2=TAB[i]	(on récupère TAB[i]=valeur contenu à l'@ TAB[i])
			STR		R2, [SP, #-4]!	@ passage du parametre par la pile (on empile TAB[i])
			BL		CARRE
			ADD		R1, R1, R0		@ calcul somme (R1=TAB[0]²+TAB[1]²+...+TAB[9]²)
			ADD		R3, R3, #1		@i++
			CMP		R3, #10
			BLT		LOOP
			LDMFD	SP!, {R0, LR}	@ restauration du contexte dont @ retour (LR)
			MOV		PC, LR          @saut à wait (fin du prog)
		
