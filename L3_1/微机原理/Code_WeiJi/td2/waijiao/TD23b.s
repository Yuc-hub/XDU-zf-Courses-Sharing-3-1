@ Fichier TD23b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o TD23b.o TD23b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o TD23b.elf TD23b.o
@ arm-elf-insight TD23b.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
A: 	.word		1, 2, 3, 4, 5, 6, 7, 8, 9, 10

@	for (i=0 ; i<10; i++) {
@		A[i]=0; //mise à 0 des cases du tableau
@	}
start:
			MOV		r1, #10			@r1=10 (nombre d'itérations)
			MOV     r0, #0			@r0=0  (valeur immédiate qui initialise les cases du tableau)
			MOV		r2, #0			@i=0   
			ADR		r3, A			@r3 = adresse de A, R3 =&A[0]
			
LOOP:		STR		r0, [r3]		@A[j]=0 (valeur contenu à l adresse A[0])
			ADD		r3, r3, #4		@j++ (décalage d'une case mémoire à chaque itération
			ADD		r2, r2, #1		@i++
			CMP 	r1, r2			@N-i (i<N?)
			BGT		LOOP			@si i<N => LOOP

wait:	b 			wait

