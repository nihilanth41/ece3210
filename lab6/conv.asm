;CONV_ASCII -- CONVERT FROM PACKED BCD TO ASCII. PACKED BCD TO CONVERT IS STORED IN CHAR_PACKED
EXTRN CHAR_PACKED: BYTE
EXTRN CHAR_H: BYTE
EXTRN CHAR_L: BYTE
PUBLIC CONV_ASCII
.MODEL small
.CODE
CONV_ASCII PROC	FAR						
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
           END