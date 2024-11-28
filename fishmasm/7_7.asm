assume cs:code, ds:data
data segment
           db 'fil             '
           db 'edi             '
           db 'vie             '
           db 'sea             '
data ends
code segment
      start:
            mov  ax, data
            mov  ds, ax
            mov  bx, 0
            mov  cx, 4
      s0:   push cx                ;将外层循环的cx值压栈
            mov  si,0
            mov  cx,3
      s:    
            mov  al,[bx+si]
            and  al,11001111b
            mov  [bx+si],al
            inc  si
            loop s
            add  bx,16
            pop  cx                ;将内层循环的cx值弹出
            loop s0
            mov  ax, 4c00h
            int  21h
code ends
end start