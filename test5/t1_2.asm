data segment
    buffer db 80 dup(?)    ; 定义一个缓冲区，大小为 80 字节，未初始化
    flag   db ?            ; 定义一个字节用作标志
data ends

code segment
main proc far
           assume cs:code,ds:data
    start: 
           push   ds
           sub    ax, ax
           push   ax
           mov    ax, data
           mov    ds, ax
           lea    bx, buffer
           mov    flag, 0

    next:  
           mov    ah, 01
           int    21h
           test   flag, 01h
           jnz    follow
           cmp    al, 20h
           jnz    exit
           mov    flag, 1
           jmp    next

    follow:
           cmp    al, 20h
           jz     exit
           mov    [bx], al           ; 存储字符到缓冲区
           inc    bx                 ; 增加缓冲区指针
           jmp    next

    exit:  
           mov    ah, 09h            ; 设置功能号 09h（输出字符串）
           lea    dx, buffer         ; 加载缓冲区地址
           int    21h                ; 输出缓冲区内容
           mov    ah, 4ch            ; 设置退出功能号
           int    21h                ; 退出程序
main endp
code ends
end start
