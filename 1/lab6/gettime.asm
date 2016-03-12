EXTRN HOURS:BYTE
EXTRN MINUTES:BYTE
EXTRN SECONDS:BYTE
EXTRN DAYLIGHT:BYTE
EXTRN RTC_STATUS:BYTE
PUBLIC GET_TIME
.MODEL small
.CODE
GET_TIME  PROC FAR
		mov ah,02h	;int 1Ah read rtc time option
		int 1ah		;invoke interrupt
		mov HOURS,CH
		mov MINUTES,CL
		mov SECONDS,DH
		mov DAYLIGHT,DL
		xor bh,bh
		adc bh,0
		mov RTC_STATUS,bh		
		   RET
GET_TIME   ENDP
           END