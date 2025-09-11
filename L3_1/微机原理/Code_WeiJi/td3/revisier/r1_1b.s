@ Fichier r1_1b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_1b.o r1_1b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_1b.elf r1_1b.o
@ arm-elf-insight r1_1b.elf   

									@ directives de compilation --------------------------
.text
.align 4 
  
.global start

									@ Section de données --------------------------
S: .word 0 
X: .word 0, 1, -2, 3, -4, 5, -6, 7, -8, 9 @ Section de code --------- 

start:	
		ADR 	r2, X 				@ r2 pointe sur X[0] 
		LDR 	r5, S
		MOV 	r1, #0							
LOOP:	LDR 	r3, [r2], #4
		CMP		r3, #0
		ADDGE	r5, r5, r3
		ADD		r1, #1
		CMP		r1, #10
		BLT		LOOP
		STR		r5, S
wait:	b 		wait
  
 
  
 
