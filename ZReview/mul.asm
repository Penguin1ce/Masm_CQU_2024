;8位在ax中
;16位dx高位和ax低位
;mov al,100
;mov bl,10
;mul bl
;结果ax=1000
;计算100*10000
;mov ax,100
;mov bx,10000
;mul bx
;结果dx=000FH ax=4240H
;F4240H=1000000
assume cs:code,ds:data
data segment
         dw 1,2,3,4,5,6,7,8
         dd 0,0,0,0,0,0,0,0
data ends
code segment
    start:
          mov  ax,data
          mov  ds,ax
          mov  si,0
          mov  di,16        ;ds:di指向第二组dword单元
          mov  cx,8
    s:    mov  bx,[si]
          call cube
          mov  [di],ax
          mov  [di].2,dx    ;相当于mov [di+2],dx
          add  si,2
          add  di,4
          loop s
          mov  ax,4c00h
          int  21h
    cube: mov  ax,bx
          mul  bx
          mul  bx
          ret
code ends
end start