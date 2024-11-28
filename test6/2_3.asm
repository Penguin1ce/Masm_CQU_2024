.model small
.data
.stack
code segment             ;代码
    Esc_key   equ 1bh
    win_ulc   equ 30
    win_ulr   equ 8
    win_lrc   equ 50
    win_lrr   equ 16
    win_width equ 20
code ends
;主函数-----------------------------------------
Code segment
main proc far
             assume cs:Code ss:stack ds:data
    ;清屏
             mov    ah,6
             mov    al,0
             mov    bh,7
             mov    ch,0
             mov    cl,0
             mov    dh,24
             mov    dl,79
             int    10h
    locate:  
             mov    ah,2
             mov    dh,win_lrr
             mov    dl,win_ulc
             mov    bh,0
             int    10h
             mov    cx,win_width
    get_char:
             mov    ah,1
             int    21h
             cmp    al,Esc_key
             jz     exit
             loop   get_char
             mov    ah,6
             mov    al,1
             mov    ch,win_ulr
             mov    cl,win_ulc
             mov    dh,win_lrr
             mov    dl,win_lrc
             mov    bh,7
             int    10h
             jmp    locate
    exit:    
             mov    ax,4c00h
             int    21h
Code ends
main endp
end main