@ Fichier r1_4b.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o r1_4b.o r1_4b.s
@ arm-elf-ld -Ttext=0x8000 -e start -o r1_4b.elf r1_4b.o
@ arm-elf-insight r1_4b.elf   

									@ directives de compilation --------------------------
.text
.align 4 
  
.global start

									@ Section de données --------------------------

start:	
main:	MOV		r0, #0
		MOV		r1, #56
		MOV		r2, #49
		BL		max
		B 		wait

max:	STR		lr, [sp, #-4]!
		CMP		r1, r2
		MOV		r0, r1
		MOVLT	r0, r2
		LDR		pc, [sp], #4
		
		
wait:	b 		wait
  
 
  
 
