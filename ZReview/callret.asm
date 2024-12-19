assume cs:code,ds:data
data segment
         db 'welcome to masm!'
data ends
code segment
    start:
          mov  ax,0
          mov  bh,1
          call s
          add  ax,2
          add  bx,1
          mov  ax,4Ch
          int  21h
    s:    
          mov  ax,4
          mov  bx,3
          ret
          
code ends
end start