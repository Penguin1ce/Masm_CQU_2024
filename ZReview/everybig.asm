assume cs:code,ds:data
data segment
         db 'word',0
         db 'unix',0
         db 'wind',0
         db 'good',0
data ends
code segment
    start:   
             mov  ax,data
             mov  ds,ax
             mov  bx,0
             mov  cx,4
    s:       mov  si,bx
             call captical
             add  bx,5
             loop s
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