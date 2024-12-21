DATAS SEGMENT
    string db 100 dup('$')    ; 存放输入字符，直到遇到 '$'
    line   db 0dh,0ah,'$'     ; 换行字符(可选)
    count  db 0               ; 用于存“数字个数”(0~255)
    sum    db 0               ; 用于存“数字和”(0~255)，不考虑溢出
DATAS ENDS
 
STACKS SEGMENT
           dw 128 dup(?)    ; 简易堆栈区(128 个字)
STACKS ENDS
 
CODES SEGMENT
               ASSUME CS:CODES, DS:DATAS, SS:STACKS

    START:     
    ; ========== 0. 初始化数据段、堆栈段 ==========
               MOV    AX, DATAS
               MOV    DS, AX

               MOV    AX, STACKS
               MOV    SS, AX
               MOV    SP, 128*2                        ; 堆栈顶(256 字节)。根据实际需要可调整

    ; ========== 1. 准备指针，循环逐字符读入直到 '$' ==========
               LEA    SI, string
               MOV    count, 0                         ; 数字个数 清0
               MOV    sum, 0                           ; 数字和 清0

    input:     
               MOV    AH, 1                            ; DOS 功能号1：逐字符输入(带回显)
               INT    21H                              ; 返回字符在 AL
               MOV    [SI], AL
               INC    SI
               CMP    AL, '$'
               JNZ    input                            ; 若不是 '$' 则继续输入

    ; ========== 2. 重新从头扫描 string，统计数字个数与和 ==========
               LEA    SI, string

    next:      
               MOV    CL, [SI]
               INC    SI
               CMP    CL, '$'
               JZ     disp                             ; 若遇到 '$' 则结束统计

               CMP    CL, '0'
               JB     next                             ; 若 < '0' 不是数字
               CMP    CL, '9'
               JA     next                             ; 若 > '9' 不是数字

    ;----- 当前字符是 '0'~'9' -----
               INC    count                            ; 数字个数 +1
               SUB    CL, '0'                          ; 转成数值(0~9)
               ADD    sum, CL                          ; sum += (CL)

               JMP    next

    ; ========== 3. 显示结果：先数字个数，再数字和 ==========
    disp:      
    ; -- (可选) 输出换行 --
               MOV    DL, 0Dh
               MOV    AH, 2
               INT    21H
               MOV    DL, 0Ah
               MOV    AH, 2
               INT    21H

    ; --- 显示“数字个数” ---
               MOV    AL, count
               CALL   Print2Dec                        ; 最多两位十进制输出
    ; 换行
               MOV    DL, 0Dh
               MOV    AH, 2
               INT    21H
               MOV    DL, 0Ah
               MOV    AH, 2
               INT    21H

    ; --- 显示“数字和” ---
               MOV    AL, sum
               CALL   Print2Dec
    ; 换行
               MOV    DL, 0Dh
               MOV    AH, 2
               INT    21H
               MOV    DL, 0Ah
               MOV    AH, 2
               INT    21H

    ; ========== 4. 结束程序 ==========
               MOV    AH, 4CH
               INT    21H

    ;------------------------------------------------------------
    ; 子程序: Print2Dec
    ;   - 入口: AL = 0~255 的数（本示例仅演示 0~99）
    ;   - 功能: 以十进制(最多两位)打印到屏幕 (不带回车)
    ;   - 若需支持 3位或以上，请自行扩展
    ;------------------------------------------------------------
Print2Dec PROC
               CMP    AL, 100
               JA     PD_3DIGITS                       ; 若想支持 3位，可自行扩展

               CMP    AL, 10
               JB     PD_1DIGIT                        ; 若 < 10, 只打印一位

    ;--------- 两位数打印 (10~99) ---------
    ; AL ÷ 10 = 商(0~9)，余(0~9)
               XOR    AH, AH
               MOV    BL, 10
               DIV    BL                               ; AL=商, AH=余
    ; 显示(商+'0')
               ADD    AL, '0'
               MOV    DL, AL
               MOV    AH, 2
               INT    21H
    ; 显示(余+'0')
               ADD    AH, '0'
               MOV    DL, AH
               MOV    AH, 2
               INT    21H
               RET

    PD_1DIGIT: 
    ;------ 一位数字(0~9) ------
               ADD    AL, '0'
               MOV    DL, AL
               MOV    AH, 2
               INT    21H
               RET

    PD_3DIGITS:
    ; 如果你需要打印三位(100~255)，可在此扩展
    ; 目前直接当作两位来演示(将不正确显示)
    ; ...
               RET
Print2Dec ENDP

CODES ENDS
END START
