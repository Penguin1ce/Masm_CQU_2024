assume ds:data,ss:stack,cs:code
data segment
    TABLE db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'
data ends
stack segment
          dw 0,0,0,0,0,0,0,0
stack ends
code segment
    start:
          mov  ax,data
          mov  ds,ax
          mov  ax,stack
          mov  ss,ax
          mov  ax,0
          mov  al,02h
    ; 设置 DS:SI 指向查找表
          lea  si, TABLE
    ; 使用 XLAT 查找字符并转换
          xlat
code ends
end start