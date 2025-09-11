@ Fichier r1_1.s  
@ export TCL_LIBRARY=/opt/GNUARM/share/tcl8.4/
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_1.o r1_1.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_1.elf r1_1.o
@ arm-elf-insight r1_1.elf

								@ directives de compilation --------------------------
		.text
		.align 4

		.global start
	
								@ Section de donn閑s --------------------------
X:		.word		0,1,2,3,4,5,6,7,8,9
N:		.word		10

								@ Section de code --------------------------
start:
		ADR		r0, X
		BL		SOMME_CARRE
		
wait:	b		wait

SOMME_CARRE:	
		STMFD	sp!, {r0, r2-r4, lr}
		MOV		r2, r0
		MOV		r4, #0
LOOP:	LDR		r3, [r2], #4
		STR		r3, [SP, #-4]!
		BL		CARRE
		ADD		r1, r1, r0
		ADD		r4, r4, #1
		CMP		r4, #10
		BLT		LOOP
		LDMFD	sp!, {r0, r2-r4, pc}
				
CARRE:	
		STMFD	sp!, {r1, lr}
		LDR		r1, [sp,#8]
		MUL		r0, r1, r1
		LDMFD	sp!, {r1, lr}
		ADD		sp, sp, #4
		MOV		pc, lr
		
