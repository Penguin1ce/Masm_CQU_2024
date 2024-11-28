assume cs:codeseg, ds:dataseg
dataseg segment
                db '1. file         '
                db '2. edit         '
                db '3. view         '
                db '4. search       '
                db '5. run          '
                db '6. debug        '
dataseg ends
codeseg segment
        start:  
                mov  ax,dataseg
                mov  ds,ax
                mov  bx,0
                mov  cx,6
        s:      mov  al,[bx+3]           ;单位是字节所以是al
                and  al,11011111b
                mov  [bx+3],al
                add  bx,16
                loop s
                mov  ax,4c00h
                int  21h
codeseg ends
end start