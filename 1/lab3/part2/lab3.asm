INCLUDE lab3.mac
TITLE 	LAB 3  
.model small
.stack 100h
.data
PROMPT_STR db "ASCII is: ",'$'	;string to clarify program purpose
HEX_ARRAY db 011H,081H,021H,047H,022H,097H,049H,090H,043H,007H 
ARRAY_SIZE EQU 9				;10 total 0-9
VAL_MAX	db ?					;location to store first ASCII char 
VAL_MIN db ?					;location to store second ASCII char
.code
main proc
mov ax,@data					;
mov ds,ax						;initialize data segment 
MOV CX,0 						;initialize counter with 0
MOV DH,HEX_ARRAY		;initialize max value w/ first value in array  
MOV DL,HEX_ARRAY		;initialize min value w/ first value in array
BEGIN_LOOP:
;compare VAL_MAX to array first
				inc CX						;increment counter 
				inc HEX_ARRAY
				cmp CX,ARRAY_SIZE			;cmp(d,s) = d-s				
				ja END_LOOP					;once counter CX reaches 10 we have check every number
CMP_MAX:
				cmp DH,HEX_ARRAY			;cmp(d,s) = d-s
				ja CMP_MIN					;val < val_max -> check minimum
				jb NEW_MAX					;val > val_max -> new max
				je BEGIN_LOOP 				;dont care if they are equal 
CMP_MIN:
				cmp DL,HEX_ARRAY			;cmp(d,s) = d-s 
				ja NEW_MIN 					;val < val_min -> new min
				jb BEGIN_LOOP				;val > val_min -> check next value in array 
				je BEGIN_LOOP 				;dont care if they're equal				
NEW_MAX:
				mov DH,HEX_ARRAY			;move value in array to max value location
				mov VAL_MAX,DH
				jmp BEGIN_LOOP				;check next value in array 
NEW_MIN:
				mov DL,HEX_ARRAY			;move value in array to min value location
				mov VAL_MIN,DH
				jmp BEGIN_LOOP				;check next value in array
END_LOOP:
MOV AH,VAL_MAX
MOV AL,VAL_MIN
RET_DOS 									;return to dos 
main endp
end main