@ Yangxi td2_ex1_2b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_2b.o td2_ex1_2b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_2b.elf td2_ex1_2b.o
@ arm-elf-insight td2_ex1_2b.elf

							@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

							@ Section de données --------------------------
A:	.word	8
C:	.word	0

							@ Section de code --------------------------
							@ R0->A, R3->C
							@ if(r0%8==0) C=A/8	else C=0;						
start:
		LDR 	r0, A
		TST		r0,#7
		BNE		ELSE
		MOV		r3,r0,ASR #3
		B		ENDIF
ELSE:	MOV		r3,#0
ENDIF:	STR		r3,C
wait:	b 	wait
  
 
  
 