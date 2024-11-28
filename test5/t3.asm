data segment
    msg    db 'input ten number:',0dh,0ah,'$'
    buffer db 20 dup(?)
    secret db 7,5,9,1,3,6,8,0,2,4                ;对应密码
data ends
code segment
          assume cs:code,ds:data
    start:
          mov    ax,data
          mov    ds, ax
          mov    si,offset buffer    ;缓冲区地址
          mov    bx,offset secret    ;密码地址
          mov    dx,offset msg       ;输出提示信息
          mov    ah,09
          int    21h
          mov    cx,10
    input:
          mov    ah,01
          int    21h
          mov    ah,0
          and    al,0fh
          mov    di,ax
          mov    al,[bx][di]         ;对应密码是首地址+偏移量（输入的数）
          mov    [si],al
          inc    si
          loop   input
          mov    ah,4ch
          int    21h
code ends
end start
