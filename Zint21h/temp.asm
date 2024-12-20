assume cs:code
code segment
    start:                    ;在屏幕上闪烁字符
          mov ah,2
          mov bh,0
          mov dh,5
          mov dl,12
          int 10h
    
          mov ah,9
          mov al,'a'
          mov bl,11001010b    ;颜色属性
          mov bh,0
          mov cx,3
          int 10h
          mov ah,4ch
          int 21h
code ends
end start