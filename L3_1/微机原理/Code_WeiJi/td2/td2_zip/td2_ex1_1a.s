@ Yangxi td2_ex1_1a.s  
@ arm-elf-as -mcpu=arm7tdmi -g -o td2_ex1_1a.o td2_ex1_1a.s
@ arm-elf-ld -Ttext=0x8000 -e start -o td2_ex1_1a.elf td2_ex1_1a.o
@ arm-elf-insight td2_ex1_1a.elf

							@ DECLARED SECTION-------------------------- 
  .text
  .align 4  
  .global start

							@ DATA SECTION --------------------------
RES:	.word	0
N:		.word   5                        @ nombre
NUM1:	.word	3, -17, 27, -12, 322

							@ CODE SECTION --------------------------
							@ CALCULATE THE SUM OF THE NUM1 ARRAY
							@ R0=SUM(NUM1)					
start:
		LDR 	r1, N			@读取数组数字个数
		ADR		r2, NUM1       @ 读取数组地址值
		MOV		r0, #0
LOOP:	LDR		r3, [r2]                     @从数组中取一个数字
		ADD		r0, r0, r3          @累加
		ADD		r2, r2, #4	@指针指向下一个数字
		SUB		r1, r1, #1                   @ 计数器减一
		CMP		r1, #0	 @ 判断是否结束运算
		BGT		LOOP		@ si R1>0 saute a loupe
		STR		r0, RES             @计算结果存入内存（RES）
wait:       B		wait

		
  
 
  
 