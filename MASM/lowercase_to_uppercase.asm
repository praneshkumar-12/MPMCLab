cr equ 0dh
lf equ 0ah

stack segment
dw 100 dup(?)
stack ends

data segment
string db 'india'
db cr, lf, '$'
strlen dw 05h
msg1 db 'The original string is '
db cr, lf, '$'
msg2 db 'The translated string is ', '$'
table db 48 dup(' '), '0123456789', 7 dup(' ')
db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 6 dup(' ')
db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 133 dup(' ')
data ends

code segment
assume cs:code, ds:data
start:

mov ax, data
mov ds, ax

mov es, ax

lea si, string
lea di, string
lea bx, table

mov cx, strlen
mov ah, 09h
lea dx, msg1
int 21h
mov ah, 09h
lea dx, string
int 21h

cld
TOP: lodsb
xlat
stosb
loop TOP

mov ah, 09h
lea dx, msg2
int 21h

mov ah, 09h
lea dx, string
int 21h

QUIT: 
mov al, 0
mov ah, 04ch
int 21H
code ends
end start
