;**********************************************************
STACK_SEG SEGMENT STACK
DB 100h DUP(?)
STACK_SEG ENDS
;**********************************************************
DATA_SEG SEGMENT 'DATA'
;*****ENTER YOUR VARIABLES HERE*****************************
PROMPT_STR DB 0AH,0DH,'Enter a character: $',0AH,0DH	;string to prompt user for input char

CHAR DB ?					;variable to hold char
DATA_SEG ENDS
;**********************************************************
CODE_SEG SEGMENT 'CODE'
ASSUME CS:CODE_SEG, DS:DATA_SEG, SS:STACK_SEG
;**********************************************************
MAIN PROC FAR
PUSH DS
MOV AX,DATA_SEG ;set the data segment location
MOV DS,AX
MOV AX,STACK_SEG ;set the stack segment location
MOV SS,AX
;**************ENTER YOUR CODE HERE*************************
;;display prompt
MOV DX, OFFSET PROMPT_STR		;move string location into DX
MOV AH, 09h				;intialize function 09h (print str)
INT 21H					;interrupt 21h (display string)

;;input character from keyboard
MOV AH,01		;option 01 read character
INT 21H			;invoke interrupt
MOV CHAR,AL		;copy char to CHAR

;;print newline/Line Feed 
MOV AH,02h		;option 2 displays 1 char
MOV DL,0Ah		;DL holds char to be displayed
INT 21H			;invoke interrupt

;;print carriage return
MOV AH,02h		;option 2 display char
MOV DL,0Dh		;0Dh is carriage return 
INT 21H			;invoke interrupt

MOV AH,02h		;single char option
MOV DL,CHAR
INT 21H			;invoke interrupt
		
.exit ;return to DOS
MAIN ENDP
CODE_SEG ENDS
END MAIN
