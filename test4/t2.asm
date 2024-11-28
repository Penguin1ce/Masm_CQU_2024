DATA SEGMENT
    CRLF             DB 0DH,0AH,'$'
    KEY_INPUT_BUFFER DB 100 DUP('$')
    STR1             DB 'INPUT STRING:','$'
    STR2             DB 'SORTED STRING:','$'
    SPACE            DB 20H,'$'
DATA ENDS

STACK SEGMENT
STACK ENDS

CODE SEGMENT
             ASSUME CS:CODE,DS:DATA
    START:   
             MOV    AX, DATA
             MOV    DS, AX
             LEA    SI, KEY_INPUT_BUFFER
             LEA    DX, STR1
             MOV    AH, 09H
             INT    21H
             LEA    DX, CRLF
             MOV    AH, 09H
             INT    21H
    INPUT:   
             MOV    AH, 1
             INT    21H
             CMP    AL, 0DH
             JE     SORT
             MOV    [SI], AL
             INC    SI
             INC    DI
             JMP    INPUT
    SORT:    
             SUB    DI, 1
             MOV    CX, DI
    LOOP1:   
             MOV    DX, CX
             MOV    BX, 0

    LOOP2:   
             MOV    AL, KEY_INPUT_BUFFER[BX]
             CMP    KEY_INPUT_BUFFER[BX+1],AL
             JNAE   CONTINUE
             XCHG   AL, KEY_INPUT_BUFFER[BX+1]
             MOV    KEY_INPUT_BUFFER[BX], AL
    CONTINUE:
             INC    BX
             LOOP   LOOP2
             MOV    CX, DX
             LOOP   LOOP1
             LEA    DX, STR2
             MOV    AH, 09H
             INT    21H
             LEA    DX, CRLF
             MOV    AH, 09H
             INT    21H
             MOV    CX, 20
             MOV    BX, 0

    EXIT1:   
             MOV    DL, KEY_INPUT_BUFFER[BX]
             MOV    DH, 0
             MOV    AH, 02
             INT    21H
             LEA    DX, SPACE
             MOV    AH, 09H
             INT    21H
             ADD    BX, 1
             LOOP   EXIT1
             LEA    DX, CRLF
             MOV    AH, 09H
             INT    21H
             MOV    CX, 20
             MOV    BX, -1
    LOOP3:   
             ADD    BX, 1
             MOV    AL, KEY_INPUT_BUFFER[BX]
             MOV    AH, 0
             CMP    AX, 30H
             JAE    LOOP4
             LOOP   LOOP3
    LOOP4:   
             CMP    AX, 39H
             JNA    EXIT2
             LOOP   LOOP3

    EXIT2:   
             MOV    DL, KEY_INPUT_BUFFER[BX]
             MOV    DH, 0
             MOV    AH, 02
             INT    21H
             LEA    DX, SPACE
             MOV    AH, 09H
             INT    21H
             LOOP   LOOP3
             MOV    AX, 4C00H
             INT    21H
CODE ENDS
END START