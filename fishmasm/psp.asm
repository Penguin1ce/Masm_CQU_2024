assume ds:data,cs:code
data segment
data ends
code segment
    start:   mov  ax, ds      ; 将 DS 寄存器指向 PSP
             mov  si, 0       ; 偏移量从 0 开始
             mov  cx, 256     ; PSP 长度为 256 字节
    psp_dump:
             mov  al, [si]    ; 从 PSP 中读取字节
    ; 这里可以将 AL 寄存器的值输出以查看
             inc  si
             loop psp_dump
code ENDS
end start