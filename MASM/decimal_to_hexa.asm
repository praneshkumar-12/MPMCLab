cr equ 0dh
lf equ 0ah

data segment
table db '0123456789ABCDEF'
decilen dw 4
decimal db '0255'
hexadecimal dw 0
multifactor dw 1
msg db 'The hexadecimal number is '
hexascii db 4 dup(?)
db cr, lf, '$'
data ends

code segment

assume cs:code, ds:data
start:

mov ax, data
mov ds, ax

mov cx, decilen

lea SI, decimal
add SI, 3

top:

mov ax, [SI]
and ax, 0000Fh
mul multifactor

add hexadecimal, ax
mov ax, multifactor
mov bx, 0000Ah
mul bx
mov multifactor, ax
dec si

loop top

lea si, hexascii

add si, 3

lea bx, table

mov ax, hexadecimal

and ax, 0000Fh
xlat
mov [si], al
dec si

mov ax, hexadecimal
and ax, 000F0h
mov cl, 04H
shr al, cl
xlat
mov [SI], al
dec si

mov ax, hexadecimal
and ax, 00F00H
mov cl, 08h
shr ax, cl
xlat
mov [si], al
dec si

mov ax, hexadecimal
and ax, 0F000H
mov cl, 00CH
shr ax, cl
xlat
mov [si], al
dec si

mov ah, 09h
lea dx, msg
int 21H

QUIT: mov al, 0
mov ah, 04ch
int 21H
code ends
end start
