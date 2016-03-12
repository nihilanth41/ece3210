EXTRN CENTURY:BYTE
EXTRN YEAR:BYTE
EXTRN MONTH:BYTE
EXTRN DAY:BYTE
EXTRN CLK_STATUS:BYTE
PUBLIC GET_DATE
.MODEL small
.CODE
GET_DATE  PROC FAR
		mov ah,04h			;int 1Ah read rtc date option
		int 1ah				;invoke interrupt
		mov CENTURY,CH
		mov YEAR,CL
		mov MONTH,DH
		mov DAY,DL
		xor bh,bh			;copy carry flag to CLK_STATUS
		adc bh,0	
		mov CLK_STATUS,bh	;CLK_STATUS=1 means clock is running
		   RET
GET_DATE   ENDP
           END