MOV AL, STATUS
AND AL, 00010101B ;只保留第1、3、5位
JZ ROUTINE_4 ;3位全为0转ROUTINE_4
JPE ROUTINE_2 ;两位为1转ROUTINE_2
CMP AL, 00010101B
JZ ROUTINE_1 ;3位全为1转ROUTINE_1
ROUTINE_3:  ;仅一位为1执行ROUTINE_3
    JMP EXIT
ROUTINE_1: 
    JMP EXIT
ROUTINE_2: 
    JMP EXIT
ROUTINE_4: 
EXIT: INT 20H