
.model small
Stack segment        ;堆栈段
Stack ends
;------------------------------------------
Data segment                         ;数据段
    user_string db 50,0,50 dup(?)
Data ends
;------------------------------------------
;main program
Code segment                                       ;代码段
read_keys proc far
              ASSUME CS:Code, DS:Data, SS:Stack
              mov    ax,@data
              mov    ds,ax
              lea    dx,user_string
              mov    ah,0ah
              int    21h
              sub    ch,ch                         ;
              mov    cl,user_string + 1
              add    dx,2
    sxit:     
              mov    ax,4c00h
              int    21h                           ;
read_keys endp
Code ends
end read_keys
