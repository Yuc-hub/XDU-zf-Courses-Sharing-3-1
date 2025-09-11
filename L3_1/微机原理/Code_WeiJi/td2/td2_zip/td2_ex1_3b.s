@ Fichier td2_ex1_3b.s  yangxi
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_3b.o td2_ex1_3b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_3b.elf td2_ex1_3b.o
@ arm-elf-insight td2_ex1_3b.elf

							@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

							@ Section de données --------------------------
A:		.word	5,3,2,1,6,7,8,9,19,10
N	 : 	.word   10

							@ Section de code --------------------------
							@ for (i=0 ; i<10 ; i++) {A[i] = 0}

start:
		MOV R4, #0   	@ i= 0
		ADR R5, A
		LDR R6, N    
		MOV R7, #0
LOOP:	STR R7,[R5],#4  @A[i]=0;R5=R5+4
		ADD R4, R4, #1	@ i = i +1
		CMP R4,R6 	 	
		BLT LOOP		@ if i<N		
wait:	b 	wait
  
 
  
 