ASSUME CS:CODE
CODE SEGMENT
    start:mov dx,1
          mov ax,86a1h    ;100001 = 186a1h 只能存放16位 4位十六进制数
          mov bx,100
          div bx
          
          mov ax,4c00h
          int 21h
CODE ENDS
end start