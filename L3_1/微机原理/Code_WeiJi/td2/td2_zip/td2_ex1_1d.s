@ Yangxi td2_ex1_1d.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_1d.o td2_ex1_1d.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_1d.elf td2_ex1_1d.o
@ arm-elf-insight td2_ex1_1d.elf

							@ DECLARED SECTION--------------------------
 
  .text
  .align 4 
  
  .global start

							@ DATA SECTION --------------------------
RES:	.word	0
N:		.word   5
							@ CODE SECTION --------------------------
							@ CALCULATE THE SUM OF THE 1+2+...+N
							@ R0=SUM(NUM1)					
start:
		LDR 	r1, N
		MOV		r0, #0
		MOV		r2, #1
LOOP:	ADD		r0, r0, r2
		ADD		r2, r2, #1
		CMP		r2, r1
		BLE		LOOP
		STR		r0, RES
		
wait:	B		wait
	
		
  
 
  
 