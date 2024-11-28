STACKS SEGMENT STACK
           DW  100H DUP(?)
           TOP LABEL WORD
STACKS ENDS
DATAS SEGMENT
    STRING1 DB  'abcd123$'
    LEN1    EQU $-STRING1
    STRING2 DB  'abcd321$'
    LEN2    EQU $-STRING2
    MATCH   DB  'MATCH!$'
    NOMATCH DB  'N$'
DATAS ENDS
CODES SEGMENT
          ASSUME CS:CODES,DS:DATAS,SS:STACKS
MAIN PROC FAR
          MOV    AX,STACKS
          MOV    SS,AX
          LEA    SP,TOP
          MOV    AX,DATAS
          MOV    DS,AX
          MOV    ES,AX
          MOV    AX,LEN1
          MOV    BX,LEN2
          CMP    AX,BX
          JNE    NO
          MOV    CH,0
          MOV    CL,AL
          LEA    SI,STRING1
          LEA    DI,STRING2
          CLD
          REPE   CMPSB
          JNE    NO
    YES:  
          LEA    DX,MATCH
          MOV    AH,09H
          INT    21H
          JMP    EXIT
    NO:   
          LEA    DX,NOMATCH
          MOV    AH,09H
          INT    21H
    EXIT: 
          MOV    AH,4CH
          INT    21H
MAIN ENDP
CODES ENDS
END MAIN