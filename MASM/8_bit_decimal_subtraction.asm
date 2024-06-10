cr equ 0dH
lf equ 0aH

data segment 

table db '0123456789ABCDEF'
n1 db 016h
n2 db 006h
result db 000h
msg db 'The result is '
asciir db 2 dup(?)
db cr, lf, '$'

data ends

code segment 

assume cs:code, ds:data
start:
mov ax, data
mov ds, ax

mov al, n1
sub al, n2
das

lea bx, table

mov result, al

lea si, asciir
add si, 1

mov al, result
and al, 00fh
xlat
mov [si], al

dec si

mov al, result
and al, 0f0h
mov cl, 04h
shr al, cl
xlat
mov [si], al

disp:

mov ah, 09h
lea dx, msg
int 21h

quit: 

mov al, 00h
mov ah, 04ch
int 21h
code ends
end start
