TITLE 	LAB 2 PART 2-- MENU DRIVEN PROGRAM 
PAGE	80,120
.model small
.stack 100h
.data
MENU_STRING	db 0AH,0DH,"Please select an option from the menu below",0Ah,0Dh
		db "a) Enter any character",0Ah,0Dh
	   	db "b) Display any character",0Ah,0Dh
	    db "c) Enter any string",0Ah,0Dh
	    db "d) Display any string",0Ah,0Dh 
	    db "e) Exit the program",0Ah,0Dh,'$'

PROMPT_A db 0AH,0DH,"Enter a character: ",'$'
PROMPT_B db 0AH,0DH,"Character entered is: ",'$'
PROMPT_C db 0AH,0DH,"Enter a string: ",'$'
PROMPT_D db 0AH,0DH,"String entered is: ",'$'
PROMPT_ERR db 0AH,0DH,"Invalid Input",'$'

CHAR db ? 								;to hold character from option a
STRING db 128,'$',128 dup('$')			;to hold string from option c

.code
main proc
mov ax,@data							;initialize data segment
mov ds,ax		

MENU_LOOP:

		mov dx,offset MENU_STRING
		mov ah,9				;option 9 print string in DX
		int 21h					;print prompt to screen

		mov ah,07				;read character option (without echo)
		int 21h					;character stored in AL
		
		cmp al,'a'				;check for option a (read character)
		je OPT_A				;jump to OPTION_A if option a selected
		cmp al,'A'				;check for uppercase A
		je OPT_A
		
		cmp al,'b'				;check for option b 
		je OPT_B				;
		cmp al,'B'				;check uppercase B
		je OPT_B
		
		cmp al,'c'
		je OPT_C
		cmp al,'C'
		je OPT_C
		
		cmp al,'d'
		je OPT_D
		cmp al,'D'
		je OPT_D

		cmp al,'e'
		je OPT_E
		cmp al,'E'
		je OPT_E
		
		mov dx,offset PROMPT_ERR	;if we get to this point then an invalid option was selected 
		mov ah,09					;print string option
		int 21h;					;print error string
				
		jmp MENU_LOOP				;loop endlessly until option e is selected
		
OPT_A:
	;READ A CHAR
		mov dx,offset PROMPT_A		;option a prompt
		mov ah,9					;9 is print string
		int 21h						;display instructions for option a
        mov ah,01h					;read char option (with echo)
		int 21h 					;invoke interrupt
		mov CHAR,al 				;copy char in AL to CHAR 
		jmp MENU_LOOP				;return to the menu 
OPT_B:
	;PRINT CHAR
		mov dx,offset PROMPT_B	;option b prompt
		mov ah,9				;print string
		int 21h					;print option b prompt
		mov ah,02				;print single character (char in DL) 
		mov dl,CHAR 			;copy CHAR to DL
		int 21h 				;invoke interrupt 
		jmp MENU_LOOP			;return to loop
OPT_C:
	;READ STRING
		mov dx,offset PROMPT_C	;option b prompt
		mov ah,9				;print string
		int 21h					;print option b prompt
		mov ah,0Ah				;read string option (string in DX)
		mov dx,offset STRING 	;move location of string buffer to DX 
		int 21h					;invoke interrupt 
		jmp MENU_LOOP			;return to loop
OPT_D:
	;PRINT STRING
		mov dx,offset PROMPT_D	;option b prompt
		mov ah,9				;print string
		int 21h					;print option b prompt
		mov ah,09				;print string option (string in DX)
		mov dx,offset STRING+2	;move location of string to DX 
		int 21h					;invoke interrupt
		jmp MENU_LOOP			;return to loop
OPT_E:	
	;EXIT PROGRAM
mov ax, 4c00h					;return to DOS
int 21h
main endp
end main

;SUBROUTINE TO CLEAR THE SCREEN (Work-in-Progress)
;------------------------------
CLEAR PROC
	mov ax,0600H
	mov bh,07
	mov cx,0000
	mov dx,184FH
	int 10h
	ret
CLEAR ENDP
;------------------------------
