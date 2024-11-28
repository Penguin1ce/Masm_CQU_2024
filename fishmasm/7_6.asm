assume cs:codeseg, ds:dataseg
dataseg segment
            db 'Chongqing'
            db 'University'
dataseg ends
codeseg segment
    start:  
            mov  ax,dataseg
            mov  ds,ax
            mov  bx,0
            mov  cx,9
    s:      mov  al,[bx]
            and  al,11011111b
            mov  [bx],al
            mov  al,[9+bx]       ;也可以这么写 mov al,[bx].9
            or   al,00100000b
            mov  [9+bx],al
            inc  bx
            loop s
            mov  ax,4c00h
            int  21h
codeseg ends
end start