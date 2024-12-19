DATA SEGMENT                    ;数据段及变量定义,2 分
      MAXLEN DB 20
      ACTLEN DB ?
      STR1   DB 21 DUP (?)
DATA ENDS
CODE SEGMENT                             ;代码段定义,1 分
            ASSUME CS:CODE,DS:DATA       ;ASSUME,1 分
      BEGIN:MOV    AX,DATA               ;DS 初始化,1 分
            MOV    DS,AX
            MOV    DX,OFFSET MAXLEN      ;字符串输入,1 分
            MOV    AH,0AH
            INT    21H
            MOV    DL,0DH                ;回车换行显示,1 分
            MOV    AH,02H
            INT    21H
            MOV    DL,0AH
            MOV    AH,02H
            INT    21H
            LEA    BX,STR1               ;添加字符串结束标志,1 分
            PUSH   BX
            MOV    CL,STR1+1
            XOR    CH,CH
            ADD    BX,CX
            MOV    [BX],'$'
            POP    BX
      LOP1: CMP    [BX],'a'              ;循环主体,2 分
            JB     L1
            CMP    [BX],'z'
            JA     L1
            SUB    [BX],20H
      L1:   INC    BX
            LOOP   LOP1
            LEA    BX,STR1               ;字符串显示,1 分
            MOV    AH,09H
            INT    21H
            MOV    AH,4CH                ;程序框架,1 分
            INT    21H
CODE ENDS
END BEGIN
