data SEGMENT
    List   db 'Chongqing University (CQU) is a key national university and a member of the “Excellence League”, located in Chongqing, Southwest China.'
           db 'It is also one of the “211 Project" and "985 Project” universities with full support in construction and development from the central'
           db 'government and Chongqing Municipal Government.'
    string db 'CQU'
data ENDS
stack SEGMENT
stack ENDS
added SEGMENT
    BLK   db 316 dup(?)
added ENDS
code SEGMENT
          ASSUME CS: code, DS: data, SS: stack
    start:
          mov    ax,data
          mov    ds,ax
          mov    ax,added
          mov    es,ax
          lea    si,List
          lea    di,BLK
          mov    ax,si
          add    ax,4
          mov    cx,100
          mov    dx,ax
    input:cld
          repe   cmpsb
          sub    dx,si
          jz     match
          lea    si,string
          mov    dx,ax
          loop   input
    match:mov    bx,di
          sub    bx,4
          mov    ah,4ch
          int    21h
code ENDS
END start