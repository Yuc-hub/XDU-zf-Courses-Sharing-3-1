@ Fichier td23a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td23a.o td23a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td23a.elf td23a.o
@ arm-elf-insight td23a.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
RES: 	.word		0     @réserve case mémoire 0 à l adresse 0x8000
N: 		.word 		5	  @réserve case mémoire 1 à l adresse 0x8004

start:
			LDR		r0, N
			MOV	r1, #0
			MOV	r2, #0			
for:			ADD	r1, r1, #1			
			CMP	r1, r0
			ADD	r2, r1, r2
			BLT		for
			STR		r2, RES 			
wait:	b 			wait
