@ Fichier td51.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td51.o td51.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td51.elf td51.o
@ arm-elf-insight td51.elf

				@ directives de compilation --------------------------
		.text
		.align 	4

		.global start
		
				@ Section de données --------------------------

X: .word 2, 4, 6, 8, 10, 12, 14, 16, 18, 20

				@ Section de code ---------
start:
	ADR r2, X @ r2 pointe sur X[0]
	MOV r0, #0 @ I=0

LOOP: 
	CMP r0, #10 @
	BGE EXIT @ si I >= 10 stop
	LDR r1, [r2] @ r1 <- X[i]
	MOV r1, r1, LSR #1 @ r1 <- X[i]/2
	STR r1, [r2] @ X[i] <- X[i]/2
	ADD r2, r2, #4 @ calcule adresse @X[i+1]
	ADD r0, r0, #1 @ I++
	B LOOP

EXIT:
wait:	B		wait
