assume cs:code,ds:data,ss:stack
stack segment
            dw 0,0,0,0,0,0,0,0
stack ends
data segment
           db '1. filename     '
           db '2. editname     '
           db '3. viewname     '
           db '4. search       '
data ends
code segment
      start:
            mov  ax,data
            mov  ds,ax
            mov  ax,stack
            mov  ss,ax
            mov  sp,16
            mov  bx,0              ;定义行
            mov  cx,4
      s0:   push cx
            mov  si,0
            mov  cx,3
      s:    mov  al,[bx+si+3]      ;定位索引
            and  al,11011111b      ;变大写字母需要将第5位置0
            mov  [bx+si+3],al      ;单位是字节所以是al
            inc  si
            loop s
            add  bx,16
            pop  cx
            loop s0
            mov  ax,4c00h
            int  21h
code ends
end start