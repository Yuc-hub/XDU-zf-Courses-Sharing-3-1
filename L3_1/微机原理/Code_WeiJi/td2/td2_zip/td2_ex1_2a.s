@ Yangxi td2_ex1_2a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_2a.o td2_ex1_2a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_2a.elf td2_ex1_2a.o
@ arm-elf-insight td2_ex1_2a.elf

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
							@ if(A==B) C=A	else C=B*8;						
start:
		LDR 	r0, A
		LDR		r1, B
		CMP		r0,r1
		BNE		ELSE
		MOV		r2,r0
		B		ENDIF
ELSE:	MOV		r2,r1,ASL #3
ENDIF:	STR		r2,C
wait:	b 	wait

   