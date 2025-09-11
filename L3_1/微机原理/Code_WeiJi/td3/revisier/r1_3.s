@ Fichier r1_3.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_3.o r1_3.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_3.elf r1_3.o
@ arm-elf-insight r1_3.elf   

									@ directives de compilation --------------------------
.text
.align 4 
  
.global start

									@ Section de données --------------------------
TABASCII: 	.byte 	0, 0, 0, 0, 0, 0, 0, 0 
VALEUR: 	.word 	0xA76E2FF1 		@ (65)(55)(54)(69)(50)(70)(70)(49)
TABCODE: 	.byte 	48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70

start:	
		MOV		r1, #7
		ADR		r2, TABASCII
		LDR		r3, VALEUR
		ADR		r4, TABCODE
LOOP:	AND		r5, r3, #0xF
		MOV		r3, r3, LSR #4
		LDRB	r6, [r4,+r5]
		STRB	r6, [r2], #1
		SUB		r1, r1, #1
		CMP		r1, #0
		BGE		LOOP
wait:	b 		wait
  
 
  
 
