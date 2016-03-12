;**********************************************************
STACK_SEG SEGMENT STACK
DB 100h DUP(?)
STACK_SEG ENDS
;**********************************************************
DATA_SEG SEGMENT 'DATA'
;*****ENTER YOUR VARIABLES HERE*****************************
PROMPT_STR	DB	'Enter a string: $'	;string to prompt user for input char
Buffer DB 100,'$',100 DUP('$') 		;max # chars expected, # of chars typed, buffer
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
MOV AH, 09h					;intialize function 09h (print str)
INT 21H					;interrupt 21h (display string)

;;input string from keyboard
MOV AH, 0AH
MOV DX, OFFSET Buffer
INT 21H

;;print newline 
MOV AH,02h		;option 2 displays 1 char
MOV DL,0Ah		;DL holds char to be displayed
INT 21H

;;str is in Buffer
MOV DX, OFFSET Buffer+2
MOV AH, 09h
INT 21H		;print string

.exit ;return to DOS
MAIN ENDP
CODE_SEG ENDS
END MAIN
