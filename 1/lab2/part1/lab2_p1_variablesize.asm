.model small
.stack 100h
.data
string1 db "Helloooooooooooooooooooooooooooooooooooooooooooooooooooooooo", 0Ah, 0Dh, "$"
string2 db 128 dup (?)
.code
main proc
mov ax,@data		;initialize data segment
mov ds,ax		;
mov dx, offset string1	;move addr string1 into dx 
mov ah,9		;print string1 to screen
int 21h			

mov bx, offset string1  ;bx contains addr string1
mov si, offset string2	;si contains addr string2

COPY_LOOP:
	mov al,[bx]		;move first byte of string 1 into AL
	mov [si],al		;move first byte from al into string 2
	
	;look for string terminator $ and break loop if found
	cmp al,'$' 		;cmp(a,b) returns a-b
	je END_LOOP		;jumps to END_LOOP if $ is encountered
	
	inc bx                  ;increment string1
	inc si                  ;increment string2
	jmp COPY_LOOP		;loop until '$' encountered

END_LOOP:
mov dx, offset string2	;move string2 into DX
mov ah,9		;print string2
int 21h
mov ax, 4c00h		;return to DOS
int 21h
main endp
end main
