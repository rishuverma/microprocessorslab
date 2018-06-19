assume cs:code,ds:data
data segment
        fname db "test.txt"
        buff db 100 dup(0)
        errmsg db "file not found$"
data ends
code segment
start:
        mov ax,data
        mov ds,ax

        mov ah,3dh
        lea dx,fname
        mov al,0
        int 21h
        jnc next
        lea dx,errmsg
        mov ah,9
        int 21h
        jmp last


 next:
        mov bx,ax
        mov ah,3fh
        mov cx,100d
        lea dx,buff
        int 21h

        mov cx,100d
        lea si,buff
 repeat:
        mov dl,[si]
        mov ah,2
        int 21h
        inc si
        loop repeat

























        mov ah,3eh
        int 21h
  
last:        mov ah,4ch
        int 21h

        code ends
        end start

