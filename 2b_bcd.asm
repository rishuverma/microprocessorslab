assume cs:code,ds:data
data segment
pa equ 20A0h 
pb equ 20A1h 
pc equ 20A2h 
cr equ 20A3h
data ends
code segment
start: 
mov ax,data 
mov ds,ax
 
mov dx,cr 
mov al,82h 
out dx,al 

mov cx,100d 
mov dx,pa 
mov al,00h
next: 
out dx,al 
call delay 
add al,01 
daa; a decimal counter, isn’t it? 
loop next 

mov cx,99d
next1: 
sub al,01 
das 
out dx,al 
call delay 
loop next1
 
mov ah,4ch 
int 21h

delay proc 
mov si,02fffh 
l2: mov di,0ffffh 
l1: dec di 
jnz l1 
dec si 
jnz l2 
ret
delay endp

code ends
end start
