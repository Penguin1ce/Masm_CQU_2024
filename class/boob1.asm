ASSUME CS:ABC
ABC SEGMENT
    START:
          MOV AX, 0001H
          MOV DS, AX
          mov ax,2
          add ax,ax
          add ax,ax
          mov ax,4c00h
          int 21h
ABC ENDS
END START