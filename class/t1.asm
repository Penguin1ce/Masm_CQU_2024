code segment
assume cs:code
	start: mov ax, 2000
		   mov ss, ax
		   mov sp, 0
		   add sp, 4
		   pop ax
		   pop bx
		   push ax
		   push bx
		   pop ax
		   pop bx
		   mov ah, 4cH
		   int 21
code ends

end start