cr equ 0dH
lf equ 0aH

data segment 

table db '0123456789ABCDEF'
n1 dw 05555h
n2 dw 05555h
result dw 00000h
msg db 'The result is '
asciir db 4 dup(?)
db cr, lf, '$'

data ends

code segment 

assume cs:code, ds:data
start:
mov ax, data
mov ds, ax

mov ax, n1
add ax, n2

lea bx, table

mov result, ax

lea si, asciir
add si, 3

mov ax, result
and ax, 0000fh
xlat
mov [si], al

dec si

mov ax, result
and ax, 000f0h
mov cl, 04h
shr al, cl
xlat
mov [si], al

dec si

mov ax, result
and ax, 00f00h
mov cl, 08h
shr ax, cl
xlat
mov [si], al

dec si

mov ax, result
and ax, 0f000h
mov cl, 0ch
shr ax, cl
xlat
mov [si], al

mov ah, 09h
lea dx, msg
int 21h

quit: 

mov al, 00h
mov ah, 04ch
int 21h
code ends
end start