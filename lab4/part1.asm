.MODEL SMALL
.STACK 64
;-------------------------------------       
.DATA
DATA1      DB   +90
DATA2      DB   +40
RESULT     DW    ?
;-------------------------------------
.CODE
MAIN PROC FAR
     MOV  AX,@DATA
     MOV  DS,AX
     SUB  AH,AH    ;AH=0
     MOV  AL,DATA1 ;GET OPERAND 1
     MOV  BL,DATA2 ;GET OPERAND 2
     ADD  AL,BL    ;ADD DATA1 AND DATA2
     JNO  OVER     ;IF OF=0 THEN GO TO OVER
     MOV  AL,DATA2 ;OTHERWISE GET OPERAND 2 TO AL
     CBW
     MOV  BX,AX    ;SAVE IT IN BX
     MOV  AL,DATA1 ;GET OPERAND 1 TO AL
     CBW  
     ADD  AX,BX    ;ADD THEM
OVER: 
	 MOV RESULT,AX;SAVE IT
	 MOV AH,04Ch  ;RETURN TO DOS 
	 INT 21H
MAIN ENDP
     END  MAIN
