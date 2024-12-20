assume ds:data, cs:code
data segment
         db 'Welcome to masm!'
         db 16 dup(0)
data ends
code segment
    start:
    ;传送的原始位置ds:si
    ;传送的目的位置es:di
    ;传送的长度cx
    ;传送的方向df
          mov ax,data
          mov ds,ax
          mov si,0
          mov es,ax
          mov di,16
          mov cx,16       ;rep循环16次
          cld
          rep movsb
          mov ax,4c00h
          int 21h
code ends
end start
