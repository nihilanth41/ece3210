INCLUDE lab3.mac
TITLE 	LAB 3  
.model small
.stack 100h
.data
PROMPT_STR db "ASCII is: ",'$'	;string to clarify program purpose
CHAR_PACKED db 0A3h				;hex value to convert to ASCII
CHAR_H	db ?					;location to store first ASCII char 
CHAR_L	db ?					;location to store second ASCII char
.code
main proc
mov ax,@data					;
mov ds,ax						;initialize data segment 
mov AL,CHAR_PACKED 				;AL=A3 
mov AH,AL						;AH=A3 
AND AX,0F00Fh					;AH=A0, AL=03 
mov CL,4 						;shr 4				
SHR AH,CL 						;AH=0A, AL=03
OR AX,3030h						;AH=3A  AL=33

;--CHECK FOR LETTER/NUMBER
CMP AH,39h						;compares value in AH to 39h 
JG HEX_ADD1						;if AH>39h then we add 7h because the result is a letter-character 
AGAIN:							;jump here after first check
CMP AL,39h						;similarly for AL
JG HEX_ADD2						;
;--jump here after LETTER/NUMBER check
CONTINUE:	
XCHG AH,AL						;swap high and low byte 
MOV CHAR_H,AH					;store in memory 
MOV CHAR_L,AL					;store in memory

;--print converted characters to screen
PRINT_STR PROMPT_STR 
PRINT_CHAR CHAR_L
PRINT_CHAR CHAR_H
;--EXIT PROGRAM
RET_DOS 				;return to DOS
;-----------
HEX_ADD1: 
ADD AH, 07h
jmp AGAIN
;-----------
HEX_ADD2:
ADD AL, 07h
jmp CONTINUE
;-----------
main endp
end main