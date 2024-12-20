data SEGMENT
      hello db 'Hello, World!', '$'      ; 定义字符串，使用 '$' 作为字符串结束符
data ENDS

code SEGMENT
            ASSUME CS:code, DS:data
      start:
      ; 初始化段寄存器
            mov    ax, data              ; 将数据段的地址加载到 AX 寄存器
            mov    ds, ax                ; 将数据段的地址传递给 DS
      ; 输出字符串
            mov    ah, 09h               ; DOS 中断 21h, 功能号 09h - 输出字符串
            lea    dx, hello             ; 将字符串地址加载到 DX 寄存器
            int    21h                   ; 调用中断

      ; 退出程序
            mov    ah, 4Ch               ; DOS 中断 21h, 功能号 4Ch - 程序退出
            int    21h                   ; 调用中断

code ENDS
END start
