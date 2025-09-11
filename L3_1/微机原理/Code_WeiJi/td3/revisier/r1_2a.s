@ Fichier r1_2a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_2a.o r1_2a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_2a.elf r1_2a.o
@ arm-elf-insight r1_2a.elf   

									@ directives de compilation --------------------------
.text
.align 4 
  
.global start

									@ Section de données --------------------------
TAB: 		.word 		3, 107, 27, 12, 322, 155, 63 
N:			.word		7

start:	
		MOV		r1, #0
		LDR		r2, N
		SUB		r0, r2, #1
		ADR		r3, TAB
		MOV		r6, r3
LOOP:	LDR		r4, [r3], #4
		LDR		r5, [r3]
		CMP		r4, r5
		BGT		INVERSER
back:	ADD		r1, r1, #1
		CMP		r1, r0
		BLT		LOOP
		SUB		r0, r0, #1
		MOV		r3, r6
		MOV		r1, #0
		CMP		r0, #1
		BGT		LOOP
		B		wait

INVERSER:	STR 	r4, [r3]
			STR		r5, [r3, #-4]
			B		back

		
		
wait:	b 		wait
  
 
  
 
