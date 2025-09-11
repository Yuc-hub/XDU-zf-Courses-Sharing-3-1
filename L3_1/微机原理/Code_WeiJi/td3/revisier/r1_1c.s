@ Fichier r1_1c.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_1c.o r1_1c.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_1c.elf r1_1c.o
@ arm-elf-insight r1_1c.elf   

									@ directives de compilation --------------------------
.text
.align 4 
  
.global start

									@ Section de données --------------------------
X: 		.word 		0, 1, 2, 3, 4, 5, 6, 7, 8, 9 
Y: 		.word 		0, 0, 0, 0, 0, 0, 0, 0, 0

start:	
		ADR 	r2, X 		@ r2 pointe sur X[0] 
		ADR 	r5, Y 		@ r4 pointe sur Y[0] 
		MOV 	r1, #1	 	@ I=1					
LOOP:	LDR		r3, [r2], #4
		LDR		r4, [r2]
		ADD		r0, r3, r4
		STR		r0, [r5],#4
		ADD		r1, r1, #1
		CMP		r1, #9
		BLE		LOOP
wait:	b 		wait
  
 
  
 
