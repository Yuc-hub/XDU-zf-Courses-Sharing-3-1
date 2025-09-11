@ Fichier TD22b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o TD22b.o TD22b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o TD22b.elf TD22b.o
@ arm-elf-insight TD22b.elf

@ directives de compilation --------------------------
.text
.align 4
.global start

@ Section de donnees --------------------------
RES: 	.word		3     @réserve case mémoire 2 à l adresse 0x8000
A: 		.word 		7	  @réserve case mémoire 1 à l adresse 0x8004

start:
			LDR		r0, A			@r0=A
			CMP     r0, #8      	@compare r0 à 8 en faisant r0-8 puis mets à jour les drapeaux (N, Z, C et V)
			BLT     ELSE        	@if (a>=8) r2=A/8 else r2=0
			MOV		r3, r0, LSR#3	@r3=r0/8 (en décalant à droite 3 fois)
			
			B       ENDIF       	@branch ENDIF

ELSE:		MOV		r0, #0
ENDIF:   	STR		r3, RES			@mémorise r3 à l adresse de base 0(=0x8000)		
wait:	b 			wait

