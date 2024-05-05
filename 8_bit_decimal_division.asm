cr equ 0dH
lf equ 0aH

data segment 

table db '0123456789ABCDEF'
n1 dw 02dh
n2 dw 006h

rem db 000h
quo db 000h

msg1 db 'The quotient is '
asquo db 2 dup(?)
db cr, lf, '$'

msg2 db 'The remainder is '
asrem db 2 dup(?)
db cr, lf, '$'

data ends

code segment 

assume cs:code, ds:data
start:
mov ax, data
mov ds, ax

mov ax, n1
aad
div n2

lea bx, table

mov quo, al
mov rem, ah

lea si, asquo
add si,1

mov al, quo
and al, 0fh
xlat
mov [si], al

dec si

mov al, quo
mov al, 0f0h
mov cl, 04h
shr al, cl
xlat
mov [si], al

mov ah, 09h
lea dx, msg1
int 21h

lea si, asrem
add si,1

mov al, rem
and al, 0fh
xlat
mov [si], al

dec si

mov al, rem
mov al, 0f0h
mov cl, 04h
shr al, cl
xlat
mov [si], al

mov ah, 09h
lea dx, msg2
int 21h

quit: 

mov al, 00h
mov ah, 04ch
int 21h
code ends
end start
