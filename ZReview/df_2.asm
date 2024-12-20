assume ds:data, cs:code
data segment
         db 16 dup(0)
data ends
code segment
    start:
    ;传送的原始位置ds:si
    ;传送的目的位置es:di
    ;传送的长度cx
    ;传送的方向df
          mov ax,0F000h
          mov ds,ax
          mov si,0ffffh
          mov ax,data
          mov es,ax
          mov di,15        ;es:di指向data:15
          mov cx,16        ;rep循环16次
          std
          rep movsb
          mov ax,4c00h
          int 21h
code ends
end start
