code segment
           assume cs:code
main proc far
    start: 
           mov    cx,4        ;四个数字循环四次 loop指令循环次数放在cx中，cx==0时顺序向下执行
           mov    bx,0        ;用bx来存放四位十六进制数，先清零
    ;执行输入过程
           mov    dh,0
    input: 
           mov    ah,01h      ;读入字符，放在al中
           int    21h
           mov    ah,0h
    ;判断是否是字母
           cmp    al,39h
           jbe    L2          ;如果从<=9说明符合0~9之间，不用减07h
           sub    al,07h
    L2:    
           sub    al,30h
           add    bx,ax
    ;判断是否是最后一位输入
           cmp    cx,1
           jz     L3          ;如果==0说明已经是最后一位，不用*16
           mov    ax,bx
           mov    dx,16       ;左移一位*16 字乘字
           mul    dx
           mov    bx,ax
    L3:    
           loop   input
           mov    dl,'='
           mov    ah,02h
           int    21h
    ;输出,十六进制转二进制一位4个数
           mov    cx,16
    output:                   ;每次左移输出一位
           rol    bx,1
           mov    dl,bl
           and    dl,01h
           add    dl,30h
           mov    ah,02h
           int    21h
           loop   output
           mov    ax,4c00h
           int    21h
main endp
code ends
end start