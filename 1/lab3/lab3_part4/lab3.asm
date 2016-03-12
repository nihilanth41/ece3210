INCLUDE lab3.mac
TITLE 	LAB 3  
.model small
.stack 100h
.data
MIN_STR db 0AH,0DH,"MINIMAL NUMBER IS: ",'$'
MAX_STR	db 0AH,0DH,"MAXIMAL NUMBER IS: ",'$'
EXTRA_STR db 0AH,0DH,"MAXIMAL NUMBER-2*MINIMAL NUMBER= ",'$'
ARRAY db 0AH,081H,021H,047H,075H,0FH,049H,090H,0AH,0AH	;array to find min/max number
COUNT EQU 10				;22number of elements in array 
MIN dw ?
MAX dw ?
MIN_C db ?
MAX_C db ?
SUB_RESULT db ?
CHAR_PACKED db ?				;hex value to convert to ASCII
CHAR_H	db ?					;location to store first ASCII char 
CHAR_L	db ?					;location to store second ASCII char
.code
;--------------------------------------------
;CONV_ASCII -- CONVERT FROM PACKED BCD TO ASCII. PACKED BCD TO CONVERT IS STORED IN CHAR_PACKED
CONV_ASCII PROC							
mov AL,CHAR_PACKED 				;copy packed BCD to AL 
mov AH,AL						;copy packed BCD to AH
AND AX,0F00Fh					;mask upper and lower nibble of high/low byte
mov CL,4 						;shift-right 4 		
SHR AH,CL 						;
OR AX,3030h						;add 30 to each byte using a bitwise OR
;CHECK FOR LETTER/NUMBER
CMP AL,39h						;if al <= 39h -> do nothing 
jle SKIP1
add AL,07h						;else add 7 (39+7=41h)
SKIP1:
CMP ah,39h
jle SKIP2							
ADD AH,07h
SKIP2:
;STORE CONVERTED CHARS AND RETURN							
XCHG AH,AL						;swap high and low byte 
MOV CHAR_H,AH					;store in memory 
MOV CHAR_L,AL					;store in memory
RET
CONV_ASCII ENDP
;--------------------------------------------
main proc
mov ax,@data					;
mov ds,ax						;initialize data segment 
;found this particular code w/ lodsw and loop instruction 
;at http://stackoverflow.com/questions/6560011/emu8086-find-minimum-and-maximum-in-an-array
mov CX,COUNT 					;initialize CX as counter (# of elements)
lea SI,ARRAY					;load array to SI 
lodsb							;loads word in SI to AX
								;first element of array is in AX 
mov MIN,AX						;use first element as reference for rest of the array
mov MAX,AX						;
dec CX
M:
	lodsb						;get next element from SI (
	cmp MIN,ax					; (min-ax)
	jle m1 						; (<=) --> keep minimum
	mov MIN,ax					; else new minimum
	jmp m2						;
m1:								;check max
	cmp MAX,ax
	jge m2						;keep max
	mov MAX,ax					;else new max
m2: 
	loop M						;loop instruction automatically decrements (E)CX
	
	mov al,byte ptr MIN
	mov ah,byte ptr MAX
	mov MIN_C,al
	mov MAX_C,ah
	;print minimum to screen
	mov CHAR_PACKED,al
	call CONV_ASCII
	PRINT_STR MIN_STR 			;print converted characters to screen (minimum first)
	PRINT_CHAR CHAR_L
	PRINT_CHAR CHAR_H
	
	;print maximum to screen
	mov al,MAX_C				;load MAX to be converted to ascii
	mov CHAR_PACKED,al			;load to correct address
	call CONV_ASCII				;hex2ascii
	PRINT_STR MAX_STR
	PRINT_CHAR CHAR_L
	PRINT_CHAR CHAR_H
	
	;calculate MAX-2*MIN and print to screen
	mov AH,MAX_C				;move max to AH
	mov AL,MIN_C				;move min to AL 					
	sub AH,AL					;MAX = max-(2*min) 
	sub AH,AL
	mov SUB_RESULT,AH			;move result into SUB_RESULT
	mov CHAR_PACKED,AH
	call CONV_ASCII
	PRINT_STR EXTRA_STR
	PRINT_CHAR CHAR_L
	PRINT_CHAR CHAR_H

;EXIT PROGRAM
RET_DOS 				;return to DOS
main endp
end main


