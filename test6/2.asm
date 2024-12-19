assume cs:code,ds:data,ss:stack
data segment
           db 'welcome to masm!'
           db 02h,24h,71h
data ends
stack segment
            dw 0,0,0,0,0,0,0,0
stack ends
code segment
      start:
            mov  ax,data
            mov  ds,ax
            mov  ax,stack
            mov  ss,ax
            mov  ax,0B800h
            mov  es,ax
            mov  bx,6e0h
            mov  di,10h
            mov  cx,3
      s:    push cx
            mov  ah,ds:[di]
            mov  bp,0
            mov  si,0
            mov  cx,16
      s0:   mov  al,ds:[bp]
            mov  es:[bx+si+40h],al
            mov  es:[bx+si+41h],ah
            add  si,2
            inc  bp
            loop s0                     ;跳转到s0
            inc  di
            add  bx,0A0h
            pop  cx
            loop s                      ;回到s
            mov  ax,4c00h
            int  21h
 
code ends
end start