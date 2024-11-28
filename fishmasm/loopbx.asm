ASSUME CS:CODE
CODE SEGMENT
    START:
          mov  ax,0740h
          mov  ds,ax
          mov  ax,0
          mov  cx,12
          mov  dx,0
          mov bx,0
    s:    mov  al,ds:[bx]
          mov  ah,0
          add  dx,ax
          inc  bx
          loop s
          mov  ax,4c00h
          int  21h
CODE ENDS
END START