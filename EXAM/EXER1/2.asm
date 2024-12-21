DATA SEGMENT
    SCORE DB 76,69,84,90,73,88,99,63,100,80
    S6    DB 0
    S7    DB 0
    S8    DB 0
    S9    DB 0
    S10   DB 0
DATA ENDS
STACK SEGMENT
          DW  10 DUP(?)
          TOP LABEL WORD
STACK ENDS
CODE SEGMENT
         ASSUME CS:CODE,SS:STACK,DS:DATA
MAIN PROC FAR
         MOV    AX,STACK
         MOV    SS,AX
         LEA    SP,TOP
         MOV    AX,DATA
         MOV    DS,AX
         LEA    SI,SCORE
         MOV    CX,10
         CLD
    L1:  LODSB
         CMP    AL,60
         JB     L5
         CMP    AL,69
         JA     L2
         INC    S6
         JMP    L6
    L2:  CMP    AL,79
         JA     L3
         INC    S7
         JMP    L6
    L3:  CMP    AL,89
         JA     L4
         INC    S8
         JMP    L6
    L4:  CMP    AL,99
         JA     L5
         INC    S9
         JMP    L6
    L5:  INC    S10
    L6:  LOOP   L1
         MOV    AH,4CH
         INT    21H
MAIN ENDP
CODE ENDS
     END MAIN 
