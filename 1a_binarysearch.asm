assume cs:code,ds:data
data segment
        a db 10h,20h,30h,40h,50h      ; Sorting only bytes. Try for words also.
	n db n-a
        key db 02h
	msg1 db "key not found$"
	msg2 db "key found at position: "
	pos db ?,"$"			; msg2 continues till here!!!
data ends

code segment
start:
        mov ax,data
        mov ds,ax

        mov al,0				; low
        mov dl,n			
        dec dl				; high = n-1 again:

  again:
        cmp al,dl
        jnz failed
        mov cl,al
        add al,dl				; low + high	
        shr al,1	; mid	
        mov ah,00h
        mov si,ax
        mov bl,[si]			; [mid] in bl
        cmp bl,key
        jae loc1				; [mid]  >=  key ?
        inc al				; no, low = mid+1, to search in second half
        jmp again

    loc1:
        je success				; [mid] = key ?
        dec al				; no, high = mid � 1, to search in first half
        mov dl,al
        mov al,cl
        jmp again

    failed:
        lea dx,msg1			; key not found
        jmp display

    success:
        inc al
        add al,30h			; store ASCII value at pos. guess why ????
        mov pos,al
        lea dx,msg2

    display:
        mov ah,9
        int 21h

        mov ah,4ch
        int 21h
code ends
end start