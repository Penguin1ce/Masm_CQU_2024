DATA SEGMENT
    X    DW 1111H
    Y    DW 2222H
    Z    DW 3333H
    V    DW 4444H
    W    DW ?,?
DATA ENDS
CODE SEGMENT
          ASSUME CS:CODE,DS:DATA
    START:
          MOV    AX,DATA
          MOV    DS,AX
          MOV    AX,X
          IMUL   Y
          MOV    CX,AX
          MOV    BX,DX
          MOV    AX,Z
          CWD
          ADD    CX,AX
          ADC    BX,DX
          SUB    CX,540
          SBB    BX,0
          MOV    AX,V
          CWD
          SUB    AX,CX
          SBB    DX,BX
          MOV    BX,X
          IDIV   BX
CODE ENDS
END START