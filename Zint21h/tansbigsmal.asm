DATA SEGMENT                ; 数据段及变量定义
    MAXLEN DB 20            ; 最大输入长度
    ACTLEN DB ?             ; 实际输入长度
    STR1   DB 21 DUP (?)    ; 字符串存储区（20字符 + 1终止符）
DATA ENDS

CODE SEGMENT                                 ; 代码段定义
                ASSUME CS:CODE, DS:DATA      ; ASSUME 指令

    BEGIN:      
                MOV    AX, DATA              ; DS 初始化
                MOV    DS, AX

    ; ========== 1. 输入字符串 ==========
                MOV    DX, OFFSET MAXLEN     ; DS:DX -> MAXLEN
                MOV    AH, 0AH               ; DOS 功能：缓冲区输入
                INT    21H

    ; ========== 2. 输出回车换行 ==========
                MOV    DL, 0DH               ; 输出回车
                MOV    AH, 02H
                INT    21H

                MOV    DL, 0AH               ; 输出换行
                MOV    AH, 02H
                INT    21H

    ; ========== 3. 给字符串添加 '$' 结尾 ==========
                LEA    BX, STR1              ; BX 指向字符串起始地址
                MOV    CL, [ACTLEN]          ; AL/CL 中保存实际输入长度
                XOR    CH, CH                ; CH = 0
                ADD    BX, CX                ; BX += 实际长度
                MOV    BYTE PTR [BX], '$'    ; 在末尾添加 '$'

    ; ========== 4. 大小写互换处理 ==========

    ; 再次让 BX 指向字符串的开头
                LEA    BX, STR1

    ; 重新加载实际长度到 CX
                MOV    CL, [ACTLEN]
                XOR    CH, CH                ; CH = 0 保证 CX=ACTLEN

    LOP1:       
    ; 读取当前字符
                MOV    AL, [BX]

    ; 检查是否为大写字母 A~Z
                CMP    AL, 'A'
                JB     CHECK_LOWER           ; 如果小于 'A'，跳转检查小写
                CMP    AL, 'Z'
                JA     CHECK_LOWER           ; 如果大于 'Z'，跳转检查小写

    ;---------- 当前是大写字母 ----------
                ADD    [BX], 20H             ; A~Z => a~z
                JMP    NEXT_CHAR

    CHECK_LOWER:
    ; 检查是否为小写字母 a~z
                CMP    AL, 'a'
                JB     NEXT_CHAR             ; 如果小于 'a'，直接不管
                CMP    AL, 'z'
                JA     NEXT_CHAR             ; 如果大于 'z'，也不管

    ;---------- 当前是小写字母 ----------
                SUB    [BX], 20H             ; a~z => A~Z

    NEXT_CHAR:  
    ; 移动到下一个字符
                INC    BX
                DEC    CX
                JNZ    LOP1

    ; ========== 5. 显示转换后的字符串 ==========
                LEA    DX, STR1              ; DX 指向 STR1
                MOV    AH, 09H               ; DOS 功能：显示字符串(以$结束)
                INT    21H

    ; ========== 6. 结束程序 ==========
                MOV    AH, 4CH               ; 4CH = 结束程序
                INT    21H

CODE ENDS
END BEGIN
