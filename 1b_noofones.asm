assume cs:code, ds:data
data segment
    pa equ 20A0h
    pb equ 20A1h
    pc equ 20A2h
    cr equ 20A3h
    msg db "No of 1's is:"
    ones db ?,"$"
data ends

code segment
   start:  mov ax,data
           mov ds,ax

           mov dx,cr
           mov al,82h    ; pa is output & pb is input
           out dx,al

           mov dx,pb
           in al,dx

           mov cx,8
           mov ah,00     ;count of 1s

      rot_again:
                ror al,1
                jnc next
                inc ah

           next:
                 loop rot_again
                 mov bl,ah
                 add ah,30h
                 mov ones,ah

                 lea dx,msg
                 mov ah,09h
                 int 21h
               

            disp:
                 mov dx,pa
                 out dx,al

                 mov ah,4ch
                 int 21h

     code ends
end start

