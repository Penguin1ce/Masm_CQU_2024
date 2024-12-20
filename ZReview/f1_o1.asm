DATA SEGMENT                ; 数据段及变量定义
    MAXLEN DB 20            ; 最大输入长度
    ACTLEN DB ?             ; 实际输入长度
    STR1   DB 21 DUP (?)    ; 字符串存储区（20字符 + 1终止符）
DATA ENDS

CODE SEGMENT                           ; 代码段定义
          ASSUME CS:CODE, DS:DATA      ; ASSUME 指令

    BEGIN:
          MOV    AX, DATA              ; DS 初始化
          MOV    DS, AX

          MOV    DX, OFFSET MAXLEN     ; 准备字符串输入
          MOV    AH, 0AH
          INT    21H

          MOV    DL, 0DH               ; 输出回车
          MOV    AH, 02H
          INT    21H

          MOV    DL, 0AH               ; 输出换行
          MOV    AH, 02H
          INT    21H

          LEA    BX, STR1              ; 添加字符串结束标志
          PUSH   BX
          MOV    CL, [ACTLEN]          ; 获取实际输入长度
          XOR    CH, CH
          ADD    BX, CX
          MOV    BYTE PTR [BX], '$'    ; 使用字符 '$' 作为终止符
          POP    BX

    LOP1: 
          CMP    BYTE PTR [BX], 'a'    ; 检查是否为小写字母 'a'
          JB     L1;小于a说明不在a-z范围内
          CMP    BYTE PTR [BX], 'z'    ; 检查是否为小写字母 'z'
          JA     L1;大于z说明不在a-z范围内
          SUB    BYTE PTR [BX], 20h    ; 转换为大写字母

    L1:   
          INC    BX                    ; 移动到下一个字符
          DEC    CX                    ; 减少计数器
          JNZ    LOP1                  ; 循环直到所有字符处理完毕

          LEA    DX, STR1              ; 加载字符串地址到 DX
          MOV    AH, 09H               ; DOS 显示字符串功能
          INT    21H

          MOV    AH, 4CH               ; 结束程序
          INT    21H
CODE ENDS
END BEGIN
