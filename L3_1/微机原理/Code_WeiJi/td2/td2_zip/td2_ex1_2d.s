@ Yangxi td2_ex1_2d.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_2d.o td2_ex1_2d.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_2d.elf td2_ex1_2d.o
@ arm-elf-insight td2_ex1_2d.elf

							@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

							@ Section de données --------------------------
A:	.word	1
B:	.word   2
C:	.word	0

							@ Section de code --------------------------
							@ R0->A, R1->B, R2->C
							@ if(A==B) C=A	else C=B;						
start:
		LDR 	r0, A
		LDR		r1, B
		CMP		r0,r1
		MOVEQ	r2,r0
		MOVNE	r2,r1
ENDIF:	STR		r2,C
wait:	b 	wait
  
 
  
 