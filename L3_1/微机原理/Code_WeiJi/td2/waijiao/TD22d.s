@ Fichier TD22d.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o TD22d.o TD22d.s
@ arm-elf-ld -Ttext=0x8000 -e start -o TD22d.elf TD22d.o
@ arm-elf-insight TD22d.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
RES: 	.word		0     @réserve case mémoire 0 à l adresse 0x8000
A: 		.word 		3	  @réserve case mémoire 1 à l adresse 0x8004
B: 		.word 		5	  @réserve case mémoire 2 à l adresse 0x8008
C:      .word		7	  @réserve case mémoire 3 à l adresse 0x800C	


start:
			LDR		r0, A			@r0=A
			LDR		r1, B			@r1=B
			LDR		r2, C			@r2=C
			
			MOV     r3, r0			@r3=A
			CMP		r0, r1          @r0-r1 => CPSR
			MOVLT   r3, r1          @si A<B => r3=B (sinon r3 reste égale à A)
			CMP		r3, r2          @r3-r2 => CPSR
			MOVLT	r3, r2			@si r3<C => r3=C
			
			STR		r3, RES			@RES=r3

wait:	b 			wait

