DATA SEGMENT
    X    DW 1111H,1122H
    Y    DW 3344H,5566H
    Z    DW 1122H,3344H
    W    DW ?,?
DATA ENDS
CODE SEGMENT
          ASSUME CS:CODE,DS:DATA
    START:
          MOV    AX,DATA
          MOV    DS,AX
          MOV    AX,X
          MOV    DX,X+2
          ADD    AX,Y
          ADC    DX,Y+2
          ADD    AX,24
          ADC    DX,0
          SUB    AX,Z
          SBB    DX,Z+2
          MOV    W,AX
          MOV    W+2,DX
          MOV    AH,4CH
          INT    21H
CODE ENDS
END START