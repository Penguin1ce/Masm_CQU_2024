assume cs:codeseg, ds:dataseg
dataseg segment
                db 'BaSic'
                db 'iNfOrMaTiOn'
dataseg ends
codeseg segment
        start:  
                mov  ax,dataseg
                mov  ds,ax               ; 设置 DS 为数据段的地址
                mov  bx,0
                mov  cx,5
        s:      mov  al,[bx]
                and  al,11011111b
                mov  [bx],al
                inc  bx
                loop s
                mov  bx,5
                mov  cx,11
        s0:     mov  al,[bx]
                or   al,00100000b
                mov  [bx],al
                inc  bx
                loop s0
                mov  ax,4c00h
                int  21h
codeseg ends
end start