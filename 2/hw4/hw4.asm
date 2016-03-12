include dosmac.mac
.MODEL	SMALL
.STACK	266
.DATA
     PROMPT    DB 'Enter a string: ', '$'
     NEWLINE   DB 0DH,0AH,'$'
     byteArea  DB 1024 dup('?')
     stringIn  DB 100           ; Max number of characters expected
     Num       DB 0             ; Actual number of characters received
     Act_Buf   DB 100 DUP ('$')

.CODE
	.STARTUP
MAIN	PROC FAR
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

		LEA DI, byteArea
		CLD 
LOOP1:
        PRINT_STR PROMPT        ; Enter a string prompt
        GET_STR stringIn        ; Get string from user
        PRINT_STR NEWLINE       ; <CR><LF>
        
		CMP Act_Buf, '$'        ; Terminate if the first character entered is '$'
        JZ OUT1
		
        MOV CH, 0
        MOV CL, Num             ; Put number of characters in CX
        LEA SI, Act_Buf         ;		        ;
        REP MOVSB               ; Copy string [si] -> [di] 
		MOV [DI], BYTE PTR 0DH	; \r	CR
		INC DI
		MOV [DI], BYTE PTR 0AH	; \n	LF
		INC DI
		
        JMP LOOP1
		
OUT1:	;terminate if '$' is first char
		;print strings in byteArea
		MOV [DI], BYTE PTR '$'
		PRINT_STR byteArea
	
	RET_DOS
	.Exit
MAIN 	ENDP
END