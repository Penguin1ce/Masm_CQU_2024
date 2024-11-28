data SEGMENT
    List   db 'Chongqing University (CQU) is a key national university and a member of the “Excellence League”, located in Chongqing, Southwest China.'
           db ' It is also one of the “211 Project" and "985 Project” universities with full support in construction and development from the central'
           db ' government and Chongqing Municipal Government.', 0                                                                                         ; 字符串结束符
    string db 'CQU', 0                                                                                                                                     ; 查找的字符串
data ENDS

stack SEGMENT
    ; stack 可以根据需要定义
stack ENDS

added SEGMENT
    BLK   db 316 dup(0)    ; 分配 316 字节空间
added ENDS

code SEGMENT
              ASSUME CS: code, DS: data, SS: stack

    start:    
    ; 初始化数据段
              mov    ax, data
              mov    ds, ax

    ; 复制字符串到 BLK
              lea    si, List                         ; SI 指向 List
              lea    di, BLK                          ; DI 指向 BLK
              mov    cx, 316                          ; 复制 316 字节
              cld                                     ; 清除方向标志

    copy_loop:
              mov    al, [si]                         ; 从 List 读取一个字节
              mov    [di], al                         ; 写入到 BLK
              inc    si                               ; SI 指向下一个字节
              inc    di                               ; DI 指向下一个字节
              loop   copy_loop                        ; 循环直到 CX 为 0

    ; 查找 "CQU" 字符串
              lea    si, BLK                          ; SI 指向 BLK
              lea    dx, string                       ; DX 指向查找字符串
              mov    cx, 316                          ; 查找前 316 字节

    find_loop:
    ; 检查是否到达查找结尾
              cmp    cx, 0
              je     not_found                        ; 如果 CX 为 0，表示未找到

    ; 逐字节比较
              mov    al, [si]                         ; 读取 BLK 当前字节
              cmp    al, [dx]                         ; 比较第一个字符
              jne    next                             ; 如果不相等，跳到 next

              mov    al, [si+1]                       ; 比较第二个字符
              cmp    al, [dx+1]
              jne    next                             ; 如果不相等，跳到 next

              mov    al, [si+2]                       ; 比较第三个字符
              cmp    al, [dx+2]
              jne    next                             ; 如果不相等，跳到 next

    ; 找到字符串
              mov    bx, si                           ; 找到时将位置存入 BX
              jmp    found

    next:     
              inc    si                               ; SI 移动到下一个字节
              dec    cx                               ; CX 减少 1
              jmp    find_loop                        ; 继续查找

    not_found:
    ; 没有找到 "CQU"
    ; 这里可以添加未找到时的处理逻辑

    found:    
    ; 处理找到字符串的逻辑
    ; 这里可以根据需要输出找到的位置
    ; 在此处结束程序
              mov    ah, 4Ch                          ; 结束程序
              int    21h

code ENDS
END start
