cr equ 0dH
lf equ 0aH

data segment 

table db '0123456789ABCDEF'
lsbdiv dw 00006h
msbdiv dw 00000h
divisor dw 00004h
quo dw 0000h
rem dw 0000h
msg db 'The quotient is '
asquo db 4 dup(?)
db cr, lf, '$'

msg1 db 'The remainder is '
asrem db 4 dup(?)
db cr, lf, '$'

data ends

code segment 

assume cs:code, ds:data
start:
mov ax, data
mov ds, ax

mov ax, lsbdiv
mov dx, msbdiv
div divisor
mov quo, ax
mov rem, dx
lea bx, table

lea si, asquo
add si,3

mov ax, quo
and ax, 0000fh
xlat
mov [si], al
dec si

mov ax, quo
and ax, 000f0h
mov cl,04h
shr al, cl
xlat
mov [si], al
dec si

mov ax, quo
and ax, 00f00h
mov cl, 08h
shr ax, cl
xlat
mov [si], al
dec si
mov ax, quo
and ax, 0f000h
mov cl, 0ch
shr ax, cl
xlat
mov [si], al

mov ah, 09h
lea dx,msg
int 21h

mov ax, rem
lea si, asrem
add si,3
and ax,0000fh
xlat
mov [si], al
dec si


mov ax, rem
and ax, 000f0h
mov cl, 04h
shr al, cl
xlat

mov [si], al
dec si
mov ax, rem
and ax, 00f00h
mov cl, 08h
shr ax, cl
xlat
mov [si], al

dec si
mov ax, rem
and ax, 0f000h
mov cl, 0ch
shr ax, cl
xlat
mov [si], al
mov ah, 09h
lea dx, msg1
int 21h

quit: mov al, 00h
mov ah,04ch
int 21h

code ends
end start
