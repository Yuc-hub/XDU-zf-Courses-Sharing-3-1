@ Fichier td31b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td31b.o td31b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td31b.elf td31b.o
@ arm-elf-insight td31b.elf

							@ directives de compilation --------------------------
	.text
	.align 4

	.global start
	
							@ Section de données --------------------------	
S:	.word	0
X: 	.word	0, 1, -2, 3, -4, 5, -6, 7, -8, 9

							@ Section de code --------------------------
start:
		ADR	r2, X
		LDR	r5, S
		MOV r0, #0	@ j=0

LOOP:	LDR r3, [r2], #4	@r3=X[i]
		cmp r3, #0
		ADDGT r5, r5, r3 		@ if (X[i]>0) S = S+X[i]
		ADD r0, r0, #1		@ j++
		CMP r0, #10
		BLT	LOOP			@ j<10
		STR r5, S
		
wait:	b	wait
