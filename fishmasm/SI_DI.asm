;SI和DI是8086CPU的两个通用寄存器，它们可以用来存放数据，也可以用来存放地址。
;但是SI和DI不能够分成两个8位寄存器来使用，它们只能作为16位寄存器来使用。
;mov si,0
;mov ax,[si]
;mov ax,[bx+si+idata]
assume cs:codeseg, ds:dataseg
dataseg segment
            db 'welcome to my world'
            db '......'
dataseg ends
codeseg segment
    start:  
            mov  ax,dataseg
            mov  ds,ax
            mov  si,0
            mov  di,20
            mov  cx,10
    s:      
            mov  ax,[si]
            mov  [di],ax
            add  si,2
            add  di,2
            loop s
            mov  ax,4c00h
            int  21h
codeseg ends
end start
