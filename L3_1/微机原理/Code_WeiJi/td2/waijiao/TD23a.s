@ Fichier TD23a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o TD23a.o TD23a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o TD23a.elf TD23a.o
@ arm-elf-insight TD23a.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
RES: 	.word		0     @réserve case mémoire 0 à l adresse 0x8000
N: 		.word 		5	  @réserve case mémoire 1 à l adresse 0x8004

@for (i=1 ; i<N; i++) => N-1 itérations car on commence à i=1
start:
			LDR		r1, N			@r0=N
			MOV     r0, #0			@r0=0
			MOV		r2, #1			@r2=1 (i)
			
LOOP:		ADD		r0, r0, r2		@total=total+i
			ADD		r2, r2, #1		@i++
			CMP 	r2, r1			@r2-r1 => CPSR (i<N?)
			BLT		LOOP			@si i<N => LOOP
					
			STR		r0, RES			@RES=r0

wait:	b 			wait

