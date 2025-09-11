@ Fichier r1_1a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_1a.o r1_1a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_1a.elf r1_1a.o
@ arm-elf-insight r1_1a.elf   

								@ directives de compilation --------------------------
.text
.align 4 
  
.global start

								@ Section de données --------------------------
S:		.word		0
X:		.word		0, 1, 2, 3, 4, 5, 6, 7, 8, 9
Y:		.word		0, 1, 2, 3, 4, 5, 6, 7, 8, 9

start:	
		ADR		r2, X
		ADR		r3, Y
		LDR		r0, S
		MOV		r1, #0
LOOP:	LDR		r4, [r2], #4
		LDR		r5, [r3], #4
		ADD		r0, r0, r4
		ADD		r0, r0, r5
		ADD		r1, r1, #1
		CMP		r1, #10
		BLT		LOOP
wait:	b 		wait
  
 
  
 
