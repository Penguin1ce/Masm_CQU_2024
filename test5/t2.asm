data segment
    a     dw 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15    ; 数组 a
    b     dw 2,4,6,8,10,12,14,16,18,20              ; 数组 b
    c     dw 10 dup(?)                              ; 数组 c
    space db 20h,'$'                                ; 用于输出的空格
data ends

code segment
main proc far
          assume cs:code, ds:data
    start:
          push   ds                  ; 保存当前数据段寄存器
          sub    ax, ax              ; AX 清零
          push   ax                  ; 压入 0
          mov    ax, data            ; 设置数据段
          mov    ds, ax
          mov    si, 0               ; SI 为数组 a 的地址下标
          mov    bx, 0               ; BX 为数组 c 的地址下标
          mov    cx, 15              ; 记录循环次数

    loop1:
          push   cx                  ; 压栈当前循环计数
          mov    cx, 10              ; 将 j 的值设置为 10（数组 b 的长度）
          mov    di, 0               ; DI 为数组 b 的地址下标
          mov    ax, [a + si]        ; AX 存放当前数组 a 的值

    loop2:
          cmp    [b + di], ax        ; 比较数组 b 的当前元素与 a 的值
          jne    loop3               ; 如果不相等，跳到 loop3
          mov    [c + bx], ax        ; 如果相等，存入数组 c
          add    bx, 2               ; 更新 c 的地址下标

    loop3:
          add    di, 2               ; 更新 b 的地址下标
          loop   loop2               ; 如果 j < 10，继续内层循环

          add    si, 2               ; 更新 a 的地址下标
          pop    cx                  ; 弹出 i 的值
          loop   loop1               ; 如果 i < 15，继续外层循环

          shr    bx, 1               ; 将 c 中的元素个数存储在 cx
          mov    cx, bx
          mov    bx, 0

    loop4:
          mov    dx, [c + bx]        ; 从数组 c 中读取元素
          add    dx, 30h             ; 转换为字符
          mov    dh, 0
          mov    ah, 02h             ; 设置输出功能
          int    21h                 ; 输出字符
          lea    dx, space
          mov    ah, 09h
          int    21h                 ; 输出空格
          add    bx, 2
          loop   loop4               ; 如果还有元素，继续输出

          ret                        ; 返回
main endp
code ends
end start
