ASSUME CS:CODE
CODE SEGMENT
    START:
          mov  ax,0011h
          mov  ax,11
          mov  cx,12
    s:    add  ax,ax
          loop s
          mov  ax,4c00h
          int  21h
CODE ENDS
END START