@ Fichier td4_ex1_1a.s  
@ export TCL_LIBRARY=/opt/GNUARM/share/tcl8.4/
@ arm-elf-as -mcpu=arm7tdmi -g -o td4_ex1_1a.o td4_ex1_1a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td4_ex1_1a.elf td4_ex1_1a.o
@ arm-elf-insight td4_ex1_1a.elf

								@ directives de compilation --------------------------
		.text
		.align 4

		.global start
	
								@ Section de données --------------------------
A:		.word		1			 
B:		.word		2			 
C:		.word		3			 

								@ Section de code --------------------------
start:
		LDR		R8, A				
		LDR		R9, B
		LDR		R4, C
		MOV		R10, #1
		BL		fonction1
		ADD		R0, R0, R8		@ R0 <- 108 + 1
		ADD		R0, R0, R9		@ R0 <- 109 + 2
		ADD		R0, R0, R10		@ Resultat attendu: 111+1=112
		
								
wait:	b	wait

		
fonction1:						@ calcule (3+C)*(2*C*C) resultat dans RO
		STMFD		SP!, {R8, R9, R10, LR}
		MOV		R10, #3			@ /!\ FONCTION1 MODIFIE R10 UTILISE DANS START /!\
								@ -> AJOUTER UNE SAUVEGARDE DU REGISTRE R10 DANS FONCTION1
		LDR		R9, C
		ADD		R8, R10, R9		@ R8 <- 6 
		BL		fonction2		@ /!\ BL FONCTION2 MODIFIE LR /!\
								@ -> AJOUTER UNE SAUVEGARDE DU REGISTRE LR DANS FONCTION1
		MUL		R0, R8, R0		@ R0 <- 6*18=108
		LDMFD		SP!, {R8, R9, R10, LR}
		MOV		PC, LR
		
fonction2:						@ calcule 2*C*C resultat dans R0
		STMFD		SP!, {R8,LR}
		MUL		R8, R4, R4		@ R8 <- 3*3=9 /!\ FONCTION2 MODIFIE R8 UTILISE DANS FONCTION1 /!\ 
								@ -> AJOUTER UNE SAUVEGARDE DU REGISTRE R8 DANS FONCTION2
		ADD		R0, R8, R8		@ Resultat: 9+9=18 dans R0
		LDMFD		SP!, {R8,LR}
		MOV		PC, LR
		
		
		@ Sans sauvegarde de contexte dans fonction1: 
								@ 1) R10 est modifie par fonction1 (avant 1, après 3)
								@ 2) le programme ne revient pas de la fonction1 (bloque a MUL R0, R8, R8) 
											
								@ Sans sauvegarde de contexte dans fonction2: 
								@ 1) R8 est modifie par fonction2 (avant 6, après 9)
								@ 2) Le resultat de fonction1 est faux : 162 (9*18) au lieu de 108 (6*18) 
								@ 3) Le resultat global est faux : 166 au lieu de 112
