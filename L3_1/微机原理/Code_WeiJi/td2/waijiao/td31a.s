@ Fichier td31a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td31a.o td31a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td31a.elf td31a.o
@ arm-elf-insight td31a.elf

							@ directives de compilation --------------------------
	.text
	.align 4

	.global start
	
							@ Section de donn�es --------------------------	
S:	.word	0
X: 	.word	0, 1, 2, 3, 4, 5, 6, 7, 8, 9
Y: 	.word	0, 1, 2, 3, 4, 5, 6, 7, 8, 9

							@ Section de code --------------------------
start:
		ADR	r2, X
		ADR	r4, Y
		LDR	r5, S
		MOV r0, #0	@ j=0

LOOP:	LDR r3, [r2], #4	@ r3=X[i], i++
		LDR r6, [r4], #4	@ r6=Y[i], i++
		ADD r5, r5, r3 		@ S <- S+X[i]
		ADD r5, r5, r6		@ S <- S+X[i] + Y[i]
		ADD r0, r0, #1		@ j++
		CMP r0, #10
		BLT	LOOP			@ j<10
		STR r5, S
		
wait:	b	wait
