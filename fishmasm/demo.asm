; DS 数据段定义
DATA SEGMENT
    ZIFU DB 'Hello World!','$'    ; 字符串定义
DATA ENDS

; SS 堆栈段定义
STACK_SEG SEGMENT
              DW 20 DUP(0)    ; 定义一个堆栈段，大小为20字（即40字节）
STACK_SEG ENDS

; CS 代码段定义
CODE SEGMENT
          ASSUME CS:CODE, DS:DATA, SS:STACK_SEG
    START:
          MOV    AX, DATA                          ; 将数据段的地址加载到 AX 寄存器
          MOV    DS, AX                            ; 设置数据段寄存器 DS 为 AX 的值
          MOV    DX, OFFSET ZIFU                   ; 将字符串的偏移地址加载到 DX 寄存器
          MOV    AH, 09H                           ; 设置 AH 为 09H，调用 DOS 中断 21H 的功能 09H（显示字符串）
          INT    21H                               ; 调用 DOS 中断，输出字符串
          MOV    AH, 4CH                           ; 设置 AH 为 4CH，调用 DOS 中断 21H 的功能 4CH（程序终止）
          INT    21H                               ; 调用 DOS 中断，结束程序
CODE ENDS
END START