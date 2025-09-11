@ Fichier td33.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td33.o td33.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td33.elf td33.o
@ arm-elf-insight td33.elf
    

									@ directives de compilation --------------------------
 
			.text
			.align 4 
  
			.global start

									@ Section de données --------------------------
TABASCII:	.byte	0, 0, 0, 0, 0, 0, 0, 0	 
VALEUR:		.word	0xA76E2FF1		
TABCODE: 	.byte	48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70

									@ Section de code --------------------------

start:
			MOV		r0, #8			@ Compteur de boucle
			LDR 	r1, VALEUR		@ r1 <- VALEUR
			ADR		r2, TABCODE		@ r2 <- @TABCODE[0]
			ADR		r3, TABASCII	@ r3 <- @TABASCII[0]
			ADD		r3, r3, #7		@ r3 <- @TABASCII[7] (pour mettre 1e poids faible de VALEUR)
LOOP:		AND		r4, r1, #0xf	@ on recupere les 4 bits de poids faible => chiffre i à convertir dans TABCODE[i]
			LDRB	r5, [r2, r4]	@ r5 <- TABCODE[r2+r4]=TABCODE[0+i] pour recuperer le code ASCII correspondant
			STRB	r5, [r3]		@ ecriture du resultat dans TABASCII[i]
			MOV		r1, r1, LSR #4	@ decalage a droite de 4 bits pour la prochaine iteration
			SUB		r3, r3, #1		@ mise a jour @TABASCII[i-1] pour iteration suivante
			SUBS 	r0, r0, #1		@ decrementer le compteur de boucle
			BNE		LOOP			 

									@ Pour finir, on bloque le processeur dans une boucle infinie vide
WAIT:   	B     	WAIT

