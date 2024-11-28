assume cs:CODE, ds:DATA
DATA SEGMENT
         db 3 dup(0)
         dw 2 dup(1)
         db 3 dup('Jcz','Firefly')
DATA ENDS
CODE SEGMENT
    start:
CODE ENDS
END START
