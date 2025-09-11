@ Fichier TD22a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o TD22a.o TD22a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o TD22a.elf TD22a.o
@ arm-elf-insight TD22a.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
A: 		.word 		12	  @réserve case mémoire 1 à l adresse 0x8000
B: 		.word 		12	  @réserve case mémoire 2 à l adresse 0x8004
RES: 	.word		3     @réserve case mémoire 3 à l adresse 0x8008

start:
			LDR		r0, A		@r0=A
			LDR		r1, B		@r1=B
			CMP     r0, r1      @compare r0 à r1 en faisant r0-r1 puis mets à jour les drapeaux (N, Z, C et V)
			BNE     ELSE        @Branch if Equal => if (a==b) c=a else c=b*8

			MOV r2, r1			@c=b
			
			B       ENDIF       @branch ENDIF

ELSE:		MOV		r2, r1, LSL#3		@r2=A
ENDIF:   	STR		r2, RES		@mémorise r2 à l adresse de base 0(=0x8000)		
wait:	b 			wait

