assume cs:code, ds:data
data segment
         db 'Hello, World!',0
data ends
code segment
    start:   
             mov  dh,8               ;dh装行数范围1-25
             mov  dl,3               ;dl装列数范围1-80
             mov  cl,2
             mov  ax,data
             mov  ds,ax
             mov  si,0
             call show_str
             mov  ah,4ch
             int  21h
    show_str:                        ;显示字符串
             push cx
             push si
             mov  al,0a0h            ;每行有80*2==160字节==0a0h字节内容
             dec  dh
             mul  dh
             mov  bx,ax
             mov  al,2               ;每个字符占两个字节
             mul  dl
             add  bx,ax
             mov  ax,0b800h          ;显存开始的地址
             mov  es,ax              ;es中存放的是显存的第0页（共0--7页）的起始的段地址
             mov  di,0
             mov  al,cl
             mov  ch,0
    s:       mov  cl,ds:[si]         ;ds:[si]指向"Hello, World!"" 取到0后跳出循环
             jcxz ok
             mov  es:[bx+di],cl      ;偶地址存放字符
             mov  es:[bx+di+1],al    ;奇地址存放字符颜色属性
             inc  si
             add  di,2
             jmp  short s
    ok:      
             pop  si
             pop  cx
             ret
code ends
end start  