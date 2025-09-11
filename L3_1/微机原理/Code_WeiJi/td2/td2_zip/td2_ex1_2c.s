@ Yangxi td2_ex1_2c.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_2c.o td2_ex1_2c.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_2c.elf td2_ex1_2c.o
@ arm-elf-insight td2_ex1_2c.elf

							@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

							@ Section de données --------------------------
A:	.word	1
B:	.word	2
C:	.word	3
MAX:.word	0

							@ Section de code --------------------------
@R0->A, R1->B, R2->C, R3->MAX
@if (A<B)
@	if (C<B) max=B;
@else if (A>C) max=A;
@	max=C;
 						
start:
		LDR 	r0, A
		LDR		r1, B
		LDR		r2, C
		CMP		r0, r1
		BLT		ELSE1
		CMP		r0,r2
		BLT		Cmax
		MOV		r3,r0
		B ENDIF
ELSE1:	CMP		r1,r2
		BLT		Cmax
		MOV		r3,r1
		B ENDIF
Cmax:   MOV		r3,r2
		B ENDIF
ENDIF:	STR		r3,MAX
wait:	b 	wait
  
 
  
 