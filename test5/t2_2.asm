data segment                                        ;数据段
    a     dw 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15    ;数组 a
    b     dw 0,2,4,6,8,9,16,17,18,19,20             ;数组 b
    c     dw 10 dup(?)                              ;数组 c
    space db 20h,'$'
data ends
code segment                           ;代码段
main proc far
          assume cs:code,ds:data
    start:
          push   ds
          sub    ax,ax
          push   ax
          mov    ax,data
          mov    ds,ax
          mov    si,0                  ;si 为数组 a 的地址下标
          mov    bx,0                  ;bx 为数组 c 的地址下标
          mov    cx,15                 ;记录循环次数
    loop1:
          push   cx                    ;i 压栈
          mov    cx,10                 ;记录 j 的值
          mov    di,0                  ;di 为数组 b 的地址下标
          mov    ax,a[si]              ;ax 存放数组 a 的值
    loop2:
          cmp    b[di],ax
          jne    loop3                 ;若 a[i]!=b[j]，转到 loop3
          mov    c[bx],ax              ;若 a[i]=b[j]，则存入数组 c
          add    bx,2
    loop3:
          add    di,2
          loop   loop2                 ;若 j<10，进入小循环
          add    si,2                  ;若 j>=10，小循环结束
          pop    cx                    ;i 出栈
          loop   loop1                 ;进入大循环
          shr    bx,1
          mov    cx,bx
          mov    bx,0
    loop4:
          mov    dx,c[bx]
          add    dx,30h
          mov    dh,0
          mov    ah,02
          int    21h
          lea    dx,space
          mov    ah,09h
          int    21h
          add    bx,2
          loop   loop4
          ret
main endp
code ends
end start