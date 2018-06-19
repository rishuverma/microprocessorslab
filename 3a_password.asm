 assume cs:code, ds:data
disp macro mesg
   lea dx, mesg
   mov ah,09
   int 21h
endm

data segment
   pwd1 db "god123"
   len1 db (len1-pwd1)
   pwd2 db 6 dup(?)
   len2 db ?
   msg1 db 0ah,0dh,"Password MAtched$"
   msg2 db 0ah,0dh,"Password did not match$"
   msg3 db 0ah,0dh,"Enter Password$"
   msg4 db 0ah,0dh,"Exceeded 3 attempts. Keyboard locked$"
data ends

code segment
     start: mov ax,data
            mov ds,ax
            mov es,ax

            mov bl,0

       rpt: call readpwd
            cld
            call match
            inc bl
            cmp bl,3
            jb rpt
            disp msg4

            mov ah,4ch
            int 21h

       readpwd proc near
            disp msg3
            mov bh,0
            lea si,pwd2

       again: mov ah,8  ; input 
              int 21h
              cmp al,0dh
              je next
              mov [si],al
              inc si
              inc bh
              mov dl, '*'
              mov ah,2
              int 21h
              jmp again

         next: mov len2,bh
               ret
          readpwd endp

         match proc near
               mov cl,len1
               cmp cl,len2
               je machstr
               jmp mismatch
      machstr: lea si,pwd1
               lea di,pwd2
               cld
               mov ch,0
               rep cmpsb
               jnz mismatch
               disp msg1
               mov ah,4ch
               int 21h

         mismatch: disp msg2
                 ret
                match endp
   code ends
   end start

