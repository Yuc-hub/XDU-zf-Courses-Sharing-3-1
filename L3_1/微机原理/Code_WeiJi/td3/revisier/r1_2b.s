@ Fichier r1_2b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_2b.o r1_2b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_2b.elf r1_2b.o
@ arm-elf-insight r1_2b.elf   

									@ directives de compilation --------------------------
.text
.align 4 
  
.global start

									@ Section de donn閑s --------------------------
TAB: 		.word 		3, 107, 27, 12, 322, 155, 63 
N:			.word		7

start:	
		ADR 	r2, TAB
		LDR		r3, N
		SUB		r3, r3, #1
		MOV		r0, #1
LOOP:	LDR		r4, [r2]
		LDR		r5, [r2, #4]	
		CMP		r4, r5
		BLE		ELSE
		STR		r5, [r2]
		STR		r4, [r2, #4]
ELSE:	CMP		r0, r3
		BEQ		NEXT
		ADD		r0, r0, #1
		ADD		r2, r2, #4
		B		LOOP
		
NEXT:	CMP		r3, #1
		BEQ		wait
		MOV		r0, #1
		ADR		r2, TAB
		SUB		r3, r3, #1
		B		LOOP
				
		
wait:	b 		wait
  
 
  

 
  
 
