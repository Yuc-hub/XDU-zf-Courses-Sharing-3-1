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
X:		.word		1, 2, 3, 4, 4, 5, 6, 7, 8, 9
Y:		.word		0, 1, 2, 3, 4, 5, 6, 7, 8, 9

@	for (i=0 ; i<10; i++) {
@		S=S+X+Y
start:
		ADR	r0, X
		LDR		r1, [r0]
		LDR		r2, [r0, #4]
		LDR		r3, [r0, #4]!
		LDR		r4, [r0], #4
		LDR		r4, [r0]

		
wait:		b 			wait
