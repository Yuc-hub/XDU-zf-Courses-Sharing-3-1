@ Fichier td2_ex1_2a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_2a.o td2_ex1_2a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_2a.elf td2_ex1_2a.o

							@ directives de compilation --------------------------
 
  .text
  .align 4 
  
  .global start

							@ Section de données --------------------------
total:	.word	0
N	 : 	.word   5

							@ Section de code --------------------------
							@ total = 0; 
							@ for (i=1 ; i<N ; i++)
							@ total = total + i; 

start:
		MOV R4, #1   	@ i= 1
		MOV R5, #0   	@ total = 0
		LDR R6, N    
LOOP:	ADD R5, R5, R4  @ total = total +i
		ADD R4, R4, #1	@ i = i +1
		CMP R4,R6 	 	
		BLT LOOP		@ if i<N
		STR R5, total
wait:	b 	wait
  
 
  
 