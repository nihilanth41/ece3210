INCLUDE lab2.mac
TITLE 	LAB 2 PART 2-- MENU DRIVEN PROGRAM 
.model small
.stack 100h
.data
;------------------------------
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
	;Valid menu options are A-E OR a-e
	;A-E is ASCII 41h-45h or 65d-69d
	;a-e is ASCII 61h-65h or 97d-101d
CHECK_LOWERCASE: 
	cmp al,'e'					;e is highest number in high range (lower case a-e) 
	ja OPT_ERR					;character is above range -> ERROR 
	cmp al,'a' 					;a is lowest number in high range (lower case a-e)  
	jb CHECK_UPPERCASE			;character is below range -> check upper case chars 
	;if we get here the character entered is lower case a-e 
	;check each character a-e and jump to their respective label if found 
	cmp al,'a'					
	je OPT_A					
	cmp al,'b'					
	je OPT_B					 
	cmp al,'c'					 
	je OPT_C					
	cmp al,'d'
	je OPT_D
	cmp al,'e'
	je OPT_EX					;**have to jmp OPT_EX instead of OPT_E because tasm complains about
								;**relative jump out of range by 0001h bytes 
	jmp MENU_LOOP				;shouldn't ever get here
	
CHECK_UPPERCASE:
	cmp al,'E'					;E is highest number in low range (upper case A-E)
	ja OPT_ERR 					;already checked lower case -> ERROR 
	cmp al,'A'					;A lowest number in low range (upper case A-E)
	jb OPT_ERR					;outside low range -> ERROR 
	;if we get here the character is upper case A-E 
	;check for each character A-E and jump to the respective label if found
	cmp al,'A'					
	je OPT_A
	cmp al,'B'					
	je OPT_B
	cmp al,'C'
	je OPT_C
	cmp al,'D'
	je OPT_D
	cmp al,'E'
	je OPT_E					
	jmp MENU_LOOP				;shouldn't ever get here
	
OPT_ERR: 
	PRINT_STR PROMPT_ERR		;if we get here then no valid options were selected 	
	jmp MENU_LOOP				;loop main menu till valid option is selected 
	
OPT_EX:							;this is here because of the jmp at line 45. Kind-of redundant. 
	;EXIT PROGRAM
	RET_DOS 					;return to DOS
	
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