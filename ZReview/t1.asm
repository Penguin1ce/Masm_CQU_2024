assume ds:data,cs:code
data segment
         dw 1234h
data ends
code segment
    start:mov ax,data
    ;   mov ds,ax
    ;   mov ax,0
    ;   mov ax,ds:[0]
    ;   mov ax,4c00h
    ;   int 21h
          mov ax,0123h
          mov ds:[0],ax
          mov word ptr ds:[2],0
          jmp dword ptr ds:[0]

code ends
end start