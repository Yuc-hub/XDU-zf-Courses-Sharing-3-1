@ 1.2
@ a)
start:
		LDR		r0, A
		LDR 	r1, B
		CMP		r0, r1
		BNE		ELSE
		STR		r0, C
		B		END_IF
ELSE:	MOV		r1, r1, LSL #3
		STR		r1, C
END_IF:	B		END_IF


@ b)
start:
		ANDS	r0, #0x7
		TST		ELSE
		MOV		r3, r0, ASR #3
		B		EDIF
ELSE:	MOV		r3, #0
ENDIF:	

@ c)
start:
		MOV		r3, r0
		CMP		r0, r1
		MOVLT	r3, r1
		CMP		r3, r2
		MOVLT	r3, r2

@ 1.3
@ a)
start:	
		LDR 	r1, N
		MOV		r2, #0
		MOV 	r0, #1
LOOP:	ADD 	r2, r2, r0
		ADD 	r0, r0, #1
		CMP 	r0, r1
		BLT		LOOP
		STR 	r2, RES
wait:	b		wait

@ b)
	.text
	.align 4
	
	.global start
	
A:		.word	5, 3, 2, 1, 6, 7, 8, 9, 19, 10
N:		.word	10

start:	
		ADR		r0, A
		LDR		r1, N
		MOV		r2, #0
		MOV		r3, #0
LOOP:	STR		r3, [r0]
		ADD		r2, r2, #1
		ADD		r0, r0, #4
		CMP		r2, r1
		BLT		LOOP
wait:	b		wait