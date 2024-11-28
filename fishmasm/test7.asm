assume cs:code
code segment
    start:
          mov  cx,5h
          mov  ax,0
          add  ax,2
    s:    
          add  ax,ax
          loop s
          mov  bx,0
          mov  ax,4c00h
          int  21h
code ends
end start