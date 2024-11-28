; assume cs:CODE,ds:DATA
; DATA SEGMENT
;     db 1;01h,在data:0处，占一个字节
;     dw 1;0001h,在data:1处，占两个字节
;     dd 1;00000001h,在data:3处，占四个字节
; DATA ENDS
ASSUME CS:CODE, DS:DATA
DATA SEGMENT
         dd 100001
         dd 100
         dd 0
DATA ENDS
CODE SEGMENT
    start:
          mov ax,DATA
          mov ds,ax
          mov ax,ds:[0]
          mov dx,ds:[2]
          div word ptr ds:[4]
          mov ds:[6],ax
          mov ax,4c00h
          int 21h
CODE ENDS
END START