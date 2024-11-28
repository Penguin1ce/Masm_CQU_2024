D_SEG SEGMENT
           AUGW LABEL WORD
    ;LABEL 定义 AUGW 为 WORD 变量,但它自身没有存储空间,而是和下面的 AUGENG 占一个空间
    AUGEND DD   99251
    ;AUGW 与 AUGEND 在存储器上占相同空间,一个 WIRD,一个 DD
    SUM    DD   ?
D_SEG ENDS                    ;数据段
;----------------------------------------------
E_SEG SEGMENT
           ADDW LABEL WORD
    ADDEND DD   -15962
E_SEG ENDS                    ;附加段
;----------------------------------------------
C_SEG SEGMENT
MAIN PROC FAR
          ASSUME CS:C_SEG,DS:D_SEG,ES:E_SEG
    START:
          PUSH   DS
          SUB    AX,AX
          PUSH   AX
          MOV    AX,D_SEG
          MOV    DS,AX                         ;为 DS 赋值
          MOV    AX,E_SEG
          MOV    ES,AX                         ;为 ES 赋值
          MOV    AX,AUGW                       ;99251-15962
          MOV    BX,AUGW+2
          ADD    AX,ES:ADDW
          ADC    BX,ES:ADDW+2
          MOV    WORD PTR SUM,AX
          MOV    WORD PTR [SUM+2],BX
          RET
MAIN ENDP
          C_SEG  EDNS                          ;代码段
END START