ASSUME cs:code
code SEGMENT
    start:
          mov ax,11
          mov bx,11h
          mov ax,4c00h
          int 21h
code ENDS
END start