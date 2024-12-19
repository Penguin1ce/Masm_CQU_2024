DATA SEGMENT                    ; 数据段及变量定义
      MAXLEN DB 20              ; 缓冲区最大长度
      ACTLEN DB ?               ; 实际输入字符数
      STR1   DB 21 DUP (?)      ; 字符串缓冲区（20 + 1 额外字节存放实际长度）
DATA ENDS

CODE SEGMENT                            ; 代码段定义
            ASSUME CS:CODE,DS:DATA      ; ASSUME
      BEGIN:
            MOV    AX,DATA              ; DS 初始化
            MOV    DS,AX
            MOV    DX,OFFSET STR1       ; 字符串输入缓冲区的地址
            MOV    AH,0AH
            INT    21H                  ; DOS 中断，读取字符串
            MOV    DL,0DH               ; 回车换行显示
            MOV    AH,02H
            INT    21H
            MOV    DL,0AH
            MOV    AH,02H
            INT    21H

            LEA    BX,STR1              ; 添加字符串结束标志
            MOV    CL, [STR1+1]         ; 获取输入的实际字符数（第二个字节）
            MOV    CX, 0                ; 清除高位
            MOV    CX, CL               ; 将字符数存入 16 位寄存器 CX
            ADD    BX, CX               ; 将 BX 定位到输入的末尾
            MOV    [BX],'$'             ; 添加字符串结束符 '$'

      LOP1: 
            CMP    [BX],'a'             ; 检查字符是否为小写字母
            JB     L1
            CMP    [BX],'z'
            JA     L1
            SUB    [BX],20H             ; 转为大写
      L1:   
            INC    BX
            LOOP   LOP1

            LEA    BX,STR1              ; 字符串显示
            MOV    AH,09H
            INT    21H                  ; 显示字符串
            MOV    AH,4CH               ; 程序退出
            INT    21H
CODE ENDS

END BEGIN
