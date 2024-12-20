assume cs:code, ds:data
data segment
    msg  db 'I love Fishc.com!', '$'
data ends
code segment
    start:
          mov ax, data
          mov ds, ax
          mov ah, 9
          lea dx, msg
          int 21h
          mov ah, 4ch
          int 21h
code ends
end start