assume cs:code
data segment
         db 'conversation'
data ends
code segment
    start:   
             mov  ax,data
             mov  ds,ax
             mov  si,0                       ;ds:si指向字符串的首地址
             mov  cx,12                      ;cx存放字符串的长度
             call captical
             mov  ax,4c00h
             int  21h
    captical:
             and  byte ptr [si],11011111b
             inc  si
             loop captical
             ret
code ends
end start