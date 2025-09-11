@ Fichier td1.s  
@ Programme de vérification des exercices du TD1
@ arm-elf-as -mcpu=arm7tdmi -g -o td1.o td1.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td1.elf td1.o
@ arm-elf-insight td1.elf

							@ directives de compilation --------------------------
 
  .text						@début de la section code exécutable
  .align 4 					@alignement du code sur 4 octets (32 bits) => instructions et données sur 32 bits pour architecture ARM
  
  .global start				@déclaration étiquette 'start' => entrée du prog (un autre programme en C ou AS peut utiliser ce point d entrée)

							@ Section de données --------------------------
DATA0:		.word 	0xA0000000    @déclarartion constante DATA0 (.word=32 bits) => mise en mémoire à partir de l adresse 0x8000
DATA1:		.word	0xF8FFEFFF    @à l adresse 0x8004
DATA2:		.word	0x8FFF0000    @à l adresse 0x8008
DATA3:		.word	0x0000000C    @à l adresse 0x800C
DATA4:		.word	0xFFFFFFFF    @à l adresse 0x8010
DATA5:		.word	0x7000FFFF    @à l adresse 0x8014
DATA6: 		.word	0x45F702A8    @à l adresse 0x8018
							@ Section de code --------------------------

start:						@étiquette 'start' => début programme principal (à l adresse 0x801C)
							@ DECALAGES
		mov 	r0, #222  
		mov 	r0, r0, LSR#2  

		mov 	r0, #222  
		mov 	r0, r0, ASR#2  		@ sur 32 bits

		mov 	r0, #222  
		mov 	r0, r0, LSL#2  

		mov 	r0, #222  
		mov 	r0, r0, ASL#2  	
			
		mov 	r0, #996  
		mov 	r0, r0, LSR#2  

		mov 	r0, #996  
		mov 	r0, r0, ASR#2  		@ sur 32 bits

		mov 	r0, #996  
		mov 	r0, r0, LSL#3  
		mov 	r0, #996  
		mov 	r0, r0, ROR#3		@ sur 32 bits  

							@ ADDITIONS
		mov 	r1, #0x08000000  
		mov 	r2, #0x07000000  
		adds	r0, r1, R2
			
		mov 	r1, #0x08000000  
		mov 	r2, #0x08000000  
		adds	r0, r1, R2
			
		mov 	r1, #0x40000000  
		mov 	r2, #0x30000000  
		adds	r0, r1, R2
			
		mov 	r1, #0x40000000  
		mov 	r2, #0x40000000  
		adds	r0, r1, R2
			
		mov 	r1, #0x08000000  
		mov 	r2, #0xFFFFFFFF  
		adds	r0, r1, R2
			
		mov 	r1, #0xF0000000  
		mov 	r2, #0xFFFFFFFF  
		adds	r0, r1, R2
			
		mov 	r1, #0x80000000  
		mov 	r2, #0xFFFFFFFF  
		adds	r0, r1, R2

		mov 	r1, #0x80000000  
		mov 	r2, #0x80000000  
		adds	r0, r1, R2
		
							@ SOUSTRACTIONS
		mov 	r1, #0x08000000  
		mov 	r2, #0x04000000  
		subs	r0, r1, R2

		mov 	r1, #0x04000000  
		mov 	r2, #0x08000000  
		subs	r0, r1, R2

		mov 	r1, #0x08000000  
		mov 	r2, #0x08000000  
		subs	r0, r1, R2

		mov 	r1, #0xF0000000  
		mov 	r2, #0x7F000000  
		subs	r0, r1, R2

		mov 	r1, #0x7F000000  
		mov 	r2, #0xF0000000  
		subs	r0, r1, R2

		@ Donner le contenu des registres R8, R7, R6, R9, R1
		@ après exécution successive des instructions suivantes :
		LDR	R0, DATA0
		LDR	R1, DATA1
		LDR	R2, DATA2
		LDR	R3, DATA3
		LDR	R4, DATA4
		LDR	R5, DATA5

		ADD 	R8, R2, R5		
		ADD 	R7, R4, R2, LSR #4
		ADD 	R6, R4, R2, ASR #4
		SUBS 	R9, R1, R6
		SUBEQ 	R1, R4, R3 
		
		@ Masquage
		@ a)
		MOV 	r0, #0x3C 		@ r0 = 0000...00111100
		AND 	r1, r0, #8 		@ r1 = r0 et 0000...01000
						@ r1 vaut a present 0000...01000

		MOV 	r0, #0x34 		@ r0 = 0000...00110100
		AND 	r1, r0, #8 		@ r1 = r0 et 0000...01000
						@ r1 vaut a prasent 0000...00000
		@ Le programme teste la valeur du bit numero trois de R0
		
		@ b) 
		LDR	r0, DATA6
		AND 	r1, r0, #0x000000FF 	@ r1 = 0x000000A8
		AND 	r2, r0, #0x0000FF00 	@ r2 = 0x00000200
		AND 	r3, r0, #0x00FF0000 	@ r3 = 0x00F70000
		AND 	r4, r0, #0xFF000000 	@ r4 = 0x45000000
		@ Le programme decompose les quatre octets de la valeur de R0

		@ c)
		MOV 	r0, #0x4C 		@ r0 = 0000...01001100
		MVN 	r1, #0x08 		@ r1 = not 0000...00001000 = 1111...11110111
		AND 	r0, r0, r1
		@ Ici, r0 vaut 0000...01000100
		@ Le programme permet de forcer à 0 la valeur de certains bits

		@ Addition d entiers longs
		@ a) Cas de l'addition sur 64 bits
		@ registres utilises : 
		@ (r1, r0) + (r3, r2) = (r5, r4) poids forts r1, r3, r5
		@ Addition des mots de poids faible et mémorisation de la retenue 
		ADDS 	r4, r0, r2
		@ Addition des mots de poids fort et de la retenue du calcul précédent 
		ADC 	r5, r1, r3

		@ b) Cas de l'addition sur 128 bits
		@ registres utilises : 
		@ (r3, r2, r1, r0) + (r7, r6, r5, r4) = (r11, r10, r9, r8)  poids forts : r3, r7, r11
		ADDS 	r8, r0, r4  @ r8=r0+r4 et mémorisation de la retenue C
		ADCS 	r9, r1, r5  @ r9=r1+r5+C et mémorisation de la retenue C
		ADCS 	r10, r2, r6 @ r10=r2+r6+C et mémorisation de la retenue C
		ADC 	r11, r3, r7 @ r11=r3+r7+C


					  		@ Pour finir, on bloque le processeur dans une boucle infinie vide
wait:		b 	wait
  
 
  
 
