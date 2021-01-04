.model small
.386
.stack 50h

.data
d1 db 0ah,"Enter first number :",24h
d2 db 0ah,"Enter second number :",24h
d3 db 0ah,"Result=",24h

num1 dd ?
num2 dd ?
num3 dd ?

.code

start:
mov ax,@data
mov ds,ax

mov dx,offset d1
mov ah,09h
int 21h
call input
mov num1,ebx

mov dx,offset d2
mov ah,09h
int 21h
call input
mov num2,ebx

mov cl,04h
mov ch,00h
mov di,offset num1
mov si,offset num2
mov bx,offset num3
clc

bcdadd:
mov dl,[si]
mov al,[di]
sbb al,dl

das
mov [bx],al
inc si
inc di
inc bx

loop bcdadd

mov ebx,num3

mov dx,offset d3
mov ah,09h
int 21h

call output
mov ah,4ch
int 21h


input proc near
 mov ebx,00000000h
 mov edx,00000000h
 mov cl,1ch
 mov ch,08h

l1:
 mov ah,01h
 int 21h
 sub al,30h

 mov dl,al
 shl edx,cl
 add ebx,edx
 mov edx,00000000h
 sub cl,04h
 sub ch,01h

 jnz l1

 ret
input endp

output proc near
 jnc l4
 mov dl,31h
 mov ah,02h
 int 21h
l4:
  mov ebp,0f0000000h
 mov cl,1ch
 mov ch,08h
l5:
 mov edx,ebx
 and edx,ebp
 shr edx,cl
 add dl,30h
 mov ah,02h
 int 21h
 mov al,cl
 mov cl,04h
 shr ebp,cl
 mov cl,al
 sub cl,04h
 sub ch,01h
 jnz l5
 ret
output endp

end start