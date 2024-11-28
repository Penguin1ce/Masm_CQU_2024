data segment
    str             db "input a string:$"
    buf             db 11
                    db ?
                    db 11 dup(?)
    srlf            db 0Ah,0Dh,"$"
    count           db "int counts:"
                    db 1 dup(?)                ;数字个数
                    db " lowercase counts:"
                    db 1 dup(?)                ;小写子母个数
                    db " capital counts:"
                    db 1 dup(?)                ;大写子母个数
                    db " other counts:"
                    db 1 dup(?)                ;其它字符的个数
                    db ' $'
    intcounts       db '0'                     ;数字个数
    lowercasecounts db '0'                     ;小写字符个数
    capitalcounts   db '0'                     ;大写字符个数
    othercounts     db '0'                     ;其它字符个数
data ends
stacks segment
           db 100 dup(?)    ;申请100个字节空间
stacks ends
code segment
main proc far
             assume cs:code,ds:data,ss:stacks
    start:   
             push   ds
             sub    ax,ax
             push   ax
             mov    ax,data
             mov    ds,ax
             mov    ah,9
             int    21h
             mov    ah,10
             lea    dx,buf
             int    21h
             lea    dx,srlf
             mov    ah,9
             int    21h
             mov    bx,-1
             mov    cx,10
    lopt:    
             add    bx,1
             mov    al,buf[bx]
             mov    ah,0
             cmp    ax,30h                       ;和0的ASCII码作比较
             jz     lopint                       ;ax=30h，即ax为0，则intcounts+1
             js     lopoth                       ;ax<30h，则othercounts+1
             cmp    ax,39h                       ;和9的ASCII码作比较，即ax>30h
             jz     lopint                       ;ax=39h，即ax为9
             js     lopint                       ;ax<39h，即ax的数值小于9，即ax在0-9之间
             cmp    ax,41h                       ;和A的作比较
             jz     lopcap
             js     lopoth
             cmp    ax,5Ah                       ;和Z作比较
             jz     lopcap
             js     lopcap
             cmp    ax,61h                       ;和a作比较
             jz     loplow
             js     lopoth
             cmp    ax,7ah                       ;和Z作比较
             jz     loplow
             js     loplow
             jmp    lopoth
    lopint:                                      ;给数字个数加一
             add    intcounts,1
             loop   lopt
             jmp    addcount
    loplow:                                      ;给小写子母个数加1
             add    lowercasecounts,1
             loop   lopt
             jmp    addcount
    lopcap:                                      ;给大写子母个数加一
             add    capitalcounts,1
             add    bx,1
             loop   lopt
             jmp    addcount
    lopoth:                                      ;给其他字符加一
             add    othercounts,1
             loop   lopt
             jmp    addcount
    addcount:                                    ;将数都加到字符串count的问号位置
             mov    al,intcounts
             mov    count[11],al
             mov    al,lowercasecounts
             mov    count[30],al
             mov    al,capitalcounts
             mov    count[49],al
             mov    al,othercounts
             mov    count[62],al
             mov    dx,offset count
             mov    ah,09h
             int    21h
             mov    ah,4ch
             int    21h
             ret
main endp
code ends
end start
