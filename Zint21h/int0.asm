assume cs:code, ds:data
data segment
         db "Welcome to Fishc.com!"
data ends
code segment
    start:   
             mov  ax,cs
             mov  ds,ax
             mov  si,offset do0                    ;传送的原始位置ds:si
             mov  ax,0
             mov  es,ax
             mov  di,200h                          ;传送的目的位置es:di

             mov  cx,offset do0end - offset do0    ;传送的长度cx
    ;-是编译器识别的运算符号，编译器可以用它来计算偏移量
             cld
             rep  movsb

             mov  ax,0                             ;设置中断向量表
             mov  es,ax
             mov  word ptr es:[0*4],200h
             mov  word ptr es:[0*4+2],0
    ;设置中断向量表
             mov  ax,4c00h
             int  21h
    do0:                                           ;显示字符串"Welcome  to Fishc.com"
    ;如何知道do0的长度
             jmp  short do0start
             db   "Welcome to Fishc.com!"
    do0start:
             mov  ax,cs
             mov  ds,ax
             mov  si,202h

             mov  ax,0b800h
             mov  es,ax
             mov  di,12*160+36*2

             mov  cx,21                            ;cx为字符串长度
    s:       mov  al,[si]
             mov  es:[di],al
             inc  si
             add  di,2
             loop s
        
             mov  ax,4c00h
             int  21h
    do0end:  nop
    
code ends
end start