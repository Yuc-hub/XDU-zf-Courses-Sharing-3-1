@ Fichier load_store.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o load_store.o load_store.s
@ arm-elf-ld -Ttext=0x8000 -e start -o load_store.elf load_store.o
@ arm-elf-insight load_store.elf   
								@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

								@ Section de données --------------------------
start:	
S:		.world		0
X:		.world		0, 1, -2, 3, -4, 5, -6, 7, -8, 9
		ADR	r2, X
		LDR		r5, S

		MOV	r0, #0
LOOP:	LDR		r3, [r2], #4
		ADD	r5, r3
		COM	r0, #10
		BLT		LOOP

		STR		r5, S
			
wait:		b 		wait
  
 
  
 
