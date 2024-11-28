assume ds:data, cs:code
data segment
         db 'unIX'
         db 'foRK'
data ends
code segment
    start:
          mov al,'a'
          or al,20h
          mov bl,'b'
          add bl,20h
          mov ax,4c00h
          int 21h
code ends
end start