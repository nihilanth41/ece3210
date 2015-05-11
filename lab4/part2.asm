.MODEL SMALL
.STACK 64
;----------------------------------
.DATA
DATA1    DB   'MiSrosoft','$'
;----------------------------------
.CODE
MAIN PROC FAR
     MOV AX,@DATA
     MOV DS,AX
     MOV ES,AX
     CLD                   ;DF=0 FOR INCREMENT
     MOV DI,OFFSET DATA1   ;ES:DI=ARRAY OFFSET
     MOV CX,0Ah            ;LENGTH OF ARRAY
     MOV AL,'S'            ;SCANNING FOR THE UPPERCASE'S'
     REPNE SCASB           ;REPEAT THE SCANNING IF NOT EQUAL
     JNE OVER              ;CX=0,THEN JUMP TO OVER
     DEC DI                ;DECREMENT TO POINT AT 'S'
     MOV BYTE PTR[DI],'c'  ;REPLACE 'S' WITH 'c'
OVER:MOV AH,09             ;DISPLAY
     MOV DX,OFFSET DATA1   
     INT 21H
	 MOV AH,04Ch  		   ;RETURN TO DOS 
	 INT 21H
MAIN ENDP
     END MAIN