@ Fichier td32.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td32.o td32.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td32.elf td32.o
@ arm-elf-insight td32.elf   
								@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

TAB:		.word		3, 107, 27, 12, 322, 155, 63
N:			.word		7

								@ Section de données --------------------------
start:	
			ADR		r0, TAB
			MOV		r1, #1
			LDR			r5, N
			B			MLOOP

INVERSER:	STR			r2, [r0]
			STR			r3, [r0, #-4]

MLOOP:		LDMIA		r0, {r2, r3}
			ADD		r0, r0, #4
			ADD		r1, r1, #1
			CMP		r1, r5
			BLT			MLOOP
			CMP		r2, r3
			BGT			INVERSER
			
			
			
wait:		b 		wait
  
 
  
 
