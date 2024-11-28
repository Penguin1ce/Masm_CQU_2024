data SEGMENT
data ENDS
code SEGMENT
          ASSUME CS: code, DS: data
    start:mov    ax,1
          mov    bx,0
          mov    cx,50
    sum:  add    bx,ax
          add    ax,2
          loop   sum
          add    ax,0
          mov    ax,4c00h
          int    21h
code ENDS
END start