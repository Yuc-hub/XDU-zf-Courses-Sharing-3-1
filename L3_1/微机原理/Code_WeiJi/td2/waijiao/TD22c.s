@ Fichier TD22c.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o TD22c.o TD22c.s
@ arm-elf-ld -Ttext=0x8000 -e start -o TD22c.elf TD22c.o
@ arm-elf-insight TD22c.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
RES: 	.word		0     @réserve case mémoire 0 à l adresse 0x8000
A: 		.word 		5	  @réserve case mémoire 1 à l adresse 0x8004
B: 		.word 		7	  @réserve case mémoire 2 à l adresse 0x8008
C:      .word		3	  @réserve case mémoire 3 à l adresse 0x800C	


start:
			LDR		r0, A			@r0=A
			LDR		r1, B			@r1=B
			LDR		r2, C			@r2=C
			
			CMP     r0, r1      	@compare r0 à r1
			BLT     ELSE1        	@if (a>b) r3=A else r3=B
			MOV		r3, r0			@r3=A
			B       COMPARE2
			
ELSE1:		MOV 	r3, r1			@r3=B
			
COMPARE2:	CMP     r3, r2      	@compare r3 à r2
			BGT     END       		@if (r3>C) fin else r3=C
			MOV		r3, r2			@r3=C
			
END:		STR		r3, RES			@RES=r3

wait:	b 			wait

