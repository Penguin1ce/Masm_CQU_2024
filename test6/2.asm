assume cs:code,ds:data,ss:stac
 
data segment
         db 'welcome to masm!'
         db 02h,24h,71h
data ends
 
stac segment
         dw 0,0,0,0,0,0,0,0
stac ends
 
code segment
    start:
          mov  ax,data
          mov  ds,ax
          mov  ax,stac
          mov  ss,ax
          mov  ax,0B800h
          mov  es,ax
	
          mov  bx,6e0h
          mov  di,10h
          mov  cx,3
 
    s:    push cx
          mov  ah,ds:[di]
          mov  bp,0
          mov  si,0
          mov  cx,16
 
    s0:   mov  al,ds:[bp]
          mov  es:[bx+si+40h],al
          mov  es:[bx+si+41h],ah
          add  si,2
          inc  bp
          loop s0
 
          inc  di
          add  bx,0A0h
          pop  cx
          loop s
 
	
          mov  ax,4c00h
          int  21h
 
code ends
 
end start