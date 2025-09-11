@ Fichier td51.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td51.o td51.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td51.elf td51.o
@ arm-elf-insight td51.elf

							@ directives de compilation --------------------------
	.text
	.align 4

	.global start
	
							@ Section de données --------------------------
X:		.word		2, 4, 6, 8, 10, 12, 14, 16, 18, 20			 

							@ Section de code --------------------------
start:
		ADR		R0, X			@ passage du parametre par le registre R0
		MOV		R1, #0		@ i=0
LOOP:		LDR		R2, [R0]		
		MOV		R2, R2, LSR #1
		STR		R2, [R0], #4
		ADD		R1, R1, #1
		CMP		R1, #9
		BLE		LOOP
			
wait:		b		wait
