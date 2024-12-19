assume cs:code
data segment
         db 'conversation',0
data ends
code segment
    start:   
             mov  ax,data
             mov  ds,ax
             mov  si,0                       ;ds:si指向字符串的首地址

             call captical
             mov  ax,4c00h
             int  21h
    captical:
             mov  cl,[si]
             mov  ch,0
             jcxz ok
             and  byte ptr [si],11011111b
             inc  si
             jmp  short captical
    ok:      ret
code ends
end start