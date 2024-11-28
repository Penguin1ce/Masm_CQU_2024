data segment                     ;define data segment
       buffer db 80 dup(?)
       flag   db ?
data ends
code segment                               ;define code segment
main proc far
              assume cs:code,ds:data
       start: 
              push   ds
              sub    ax,ax
              push   ax
              mov    ax,data
              mov    ds,ax
              lea    bx,buffer
              mov    flag,0
       next:  
              mov    ah,01
              int    21h
              test   flag,01h
              jnz    follow
              cmp    al,20h
              jnz    exit
              mov    flag,1
              jmp    next
       follow:
              cmp    al,20h
              jz     exit
              mov    [bx],al
              inc    bx
              jmp    next
       exit:  
              mov    ah,4ch
              int    21h
main endp
code ends
end start