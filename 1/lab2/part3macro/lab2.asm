INCLUDE lab2.mac
TITLE 	LAB 2 PART 2-- MENU DRIVEN PROGRAM 
.model small
.stack 100h
.data
MENU_STRING	db 0AH,0DH,"Please select an option from the menu below",0Ah,0Dh
			db "a) Enter any character",0Ah,0Dh
			db "b) Display any character",0Ah,0Dh
	    	db "c) Enter any string",0Ah,0Dh
	    	db "d) Display any string",0Ah,0Dh 
	    	db "e) Exit the program",0Ah,0Dh,'$'

PROMPT_A    db 0AH,0DH,"Enter a character: ",'$'
PROMPT_B    db 0AH,0DH,"Character entered is: ",'$'
PROMPT_C    db 0AH,0DH,"Enter a string: ",'$'
PROMPT_D    db 0AH,0DH,"String entered is: ",'$'
PROMPT_ERR  db 0AH,0DH,"Invalid Input",'$'

CHAR db ? 						;to hold character from option a
STRING db 128,'$',128 dup('$')	;to hold string from option c

.code
;SUBROUTINE TO CHECK FOR VALID MENU INPUT
;------------------------------
COMPARE PROC
	cmp al,'a'					;check for option a (read character)
	je OPT_A					;jump to OPTION_A if option a selected
	cmp al,'A'					;check for upper case A
	je OPT_A
	
	cmp al,'b'					;check for option b 
	je OPT_B					
	cmp al,'B'					;check upper case B
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
	
	PRINT_STR PROMPT_ERR		;if we get here then no valid options were selected 
				
	jmp MENU_LOOP				;loop main menu till valid option is selected 				
COMPARE ENDP
;------------------------------

main proc
mov ax,@data	
mov ds,ax						;initialize data segment

MENU_LOOP:
	;MAIN MENU
		PRINT_STR MENU_STRING	;print main menu to screen
		GET_CHARNE				;read character (no echo)
		CALL COMPARE 			;check user-input against menu options
OPT_A:
	;READ A CHAR
		PRINT_STR PROMPT_A		;option a prompt
		GET_CHAR CHAR 			;get char from user and store at CHAR
		jmp MENU_LOOP			;return to the menu 
OPT_B:
	;PRINT CHAR
		PRINT_STR PROMPT_B		;print option b prompt
		PRINT_CHAR CHAR			;print single character stored at CHAR
		jmp MENU_LOOP			;return to loop
OPT_C:
	;READ STRING
		PRINT_STR PROMPT_C		;print option c prompt
		GET_STR STRING			;get string from user and store at STRING 
		jmp MENU_LOOP			;return to loop
OPT_D:
	;PRINT STRING
		PRINT_STR PROMPT_D		;print option d prompt
		PRINT_STR STRING+2
		jmp MENU_LOOP			;return to loop
OPT_E:	
	;EXIT PROGRAM
		RET_DOS 				;return to DOS
main endp
end main