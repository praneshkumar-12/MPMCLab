cr equ 0dh
lf equ 0ah

data segment
table db '0123456789ABCDEF'

string1 db 'process'
db cr, lf, '$'


strlength equ $-string1-3

str db 'The given word is '
db cr, lf, '$'

strl db 'The given word length is '
xyz db 1 dup(0)
db cr, lf, '$'

msg1 db 'The given word is palindrome.'
db cr, lf, '$'
msg2 db 'The given word is not a palindrome.'
db cr, lf, '$'
string2 db 5 dup(' ')
db cr, lf, '$'
data ends

code segment
assume cs:code, ds:data
start:
mov ax, data
mov ds, ax
mov es, ax

mov ah, 09h
lea dx, str
int 21h

mov ah, 09h
lea dx, string1
int 21h

lea si, xyz
mov al, strlength
xlat
mov [si], al
mov ah, 09h
lea dx, strl
int 21h


lea si, string1
lea di, string2+strlength-1

mov cx, strlength

TOP: 
	cld
	lodsb
	std
	stosb
loop TOP

lea si, string1
lea di, string2
cld

mov cx, strlength
repe cmpsb

cmp cx, 00h
jnz NOTPALINDROME

mov ah, 09h
lea dx, msg1
int 21h

jmp quit

NOTPALINDROME: mov ah, 09h
lea dx, msg2
int 21h

QUIT: 
mov al, 0
mov ah, 04ch
int 21H

code ends
end start




