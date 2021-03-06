.MODEL SMALL
.STACK 64
;----------------------------------------
.DATA
STR1    DB      'RACECA','$',0AH,0DH 
DATA2	DB		10,'$',10 dup('$')
STR_PALIN  DB  0AH,0DH,'STRING IS PALINDROME.','$'
STR_NOT_PALIN	DB	0AH,0DH,'STRING IS NOT PALINDROME.','$'
;----------------------------------------
.CODE 
MAIN PROC FAR
      MOV AX,@DATA
      MOV DS,AX
      MOV SI,OFFSET STR1   ;DATA1 USED TO STORE THE STRING
      MOV DI,OFFSET DATA2  ;DATA2 USED TO STORE THE REVERSE STRING
;PRINT THE STRING     
      MOV AH,09H           ;DISPLAY FUNCTION
      MOV DX,OFFSET STR1   ;DX POINTS TO OUTPUT BUFFER
      INT 21H

;GET THE REVERSE OF THE STRING
      MOV CX,0             ;CX=0
  L1: INC SI
      INC CX
      CMP BYTE PTR[SI],'$' ;FIND THE END OF THE STRING 
      JNE L1               ;REFIND IF NOT '$'
      DEC SI               ;GET THE LAST ADDRESS OF THE STRING
      MOV DI, OFFSET DATA2 ;GET THE ADDRESS OF THE REVERSE STRING
  
  L2: MOV AL,BYTE PTR[SI]  ;SEND THE CONTENT OF THE STRING TO AL
      MOV BYTE PTR[DI],AL  ;INPUT THE REVERSE STRING'S ADDRESS TO DI        
      DEC SI               
      INC DI
      LOOP L2
      MOV BYTE PTR[DI],'$' ;THE END OF THE REVERSE STRING
	  ;reverse string in DATA2

	  

;PRINT THE STRING IS PALINDROME OR NOT
      MOV SI,offset STR1		   ;THE STRING
      MOV DI,offset DATA2         ;THE REVERSE STRING

  L3: MOV BL,BYTE PTR[DI]  ;INPUT ONE CHARACTER INTO BL
      CMP BYTE PTR[SI],BL  ;COMPARA THE SAME POSITION OF TWO STRING
      JNE L4               ;TWO STRING ARE NOT SAME
      INC SI
      INC DI
      CMP BYTE PTR[DI],'$' ;KNOW WHETHER THE STRING IS END OR NOT
      JNE L3               ;CONTINUE LOOP IF NOT
      MOV AH,09H           ;THE STRING IS PALIN,DISPLAY THE RESULT
      MOV DX, OFFSET STR_PALIN
      INT 21H
      
      JMP L5               ;END THIS PROGRAM
      
  L4: MOV AH,09H
      MOV DX,OFFSET STR_NOT_PALIN
      INT 21H 

  L5: MOV AH,4CH
      INT 21H
MAIN ENDP
     END MAIN
      