@ Fichier td31a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td31a.o td31a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td31a.elf td31a.o
@ arm-elf-insight td31a.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
S: 		.word		0
X:		.word		0, 1, 2, 3, 4, 5, 6, 7, 8, 9
Y:		.word		0, 1, 2, 3, 4, 5, 6, 7, 8, 9

@	for (i=0 ; i<10; i++) {
@		S=S+X+Y
start:
		LDR		r0, S
		ADR	r1, X
		ADR	r2, Y
		MOV	r3, #0

LOOP:		LDR		r4, [r1]
			LDR		r5, [r2]
			ADD	r0, r0, r4
			ADD	r0, r0, r5
			ADD	r3, r3, #1
			ADD	r1, r1, #4
			ADD	r2, r2, #4
			CMP	r3, #10
			BLT		LOOP
			STR		r3, S
wait:		b 			wait
