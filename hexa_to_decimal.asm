cr equ 0dh
lf equ 0ah
data segment
table db '0123456789ABCDEF'
hexadec dw 000FFh
msg db 'The decimal number is '
deci db 4 dup(?)
db cr, lf, '$'
data ends

code segment
assume cs:code, ds:data
start:

mov ax, data
mov ds, ax

mov ax, hexadec
mov cx, 0000ah

lea bx,table

lea SI, deci

add SI,3

TOP: 
cmp ax,cx
jb BOTTOM
xor dx, dx
div cx
push ax
mov al, dl
xlat
mov [si],al
pop ax
dec si
jmp TOP

BOTTOM: xlat
mov [si], al

mov ah, 09h
lea dx, msg
int 21h

QUIT: 
mov al, 0
mov ah, 04ch
int 21H
code ends
end start




