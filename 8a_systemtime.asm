assume cs:code
code segment
start:
        mov ah,2ch
        int 21h

        mov al,ch
        call disp
        mov dl,':'
        mov ah,2
        int 21h

        mov al,cl
        call disp

        mov ah,4ch
        int 21h

disp proc
     aam
     add ax,3030h
     mov dl,ah
     mov ah,2
     push ax
     int 21h
     pop ax
     mov dl,al
     mov ah,2
     int 21h
     ret           
disp endp

     code ends
end start

