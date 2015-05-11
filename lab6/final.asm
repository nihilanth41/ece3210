EXTRN GET_TIME: FAR
EXTRN GET_DATE: FAR
EXTRN CONV_ASCII: FAR
PUBLIC CENTURY,YEAR,MONTH,DAY,CLK_STATUS,HOURS,MINUTES,SECONDS,DAYLIGHT,RTC_STATUS,CHAR_PACKED,CHAR_H,CHAR_L
INCLUDE final.mac
;LABEL COLUMNS 79
.MODEL SMALL
.386
.STACK 64
;----------------------------------------
.DATA
MENU_STR db '--Menu Interface--','$'
OPT1 db 0AH,0DH,'[D] Display the date','$'
OPT2 db 0AH,0DH,'[T] Display the time','$'
OPT3 db 0AH,0DH,'[Q] Exit','$'
DATE_STR db 0AH,0DH,"Today's date: ",'$'
TIME_STR db 0AH,0DH,"Current time: ",'$'
USR_INPUT db ?
;vars for getdate
CENTURY db ?
MONTH db ?
DAY db ?
YEAR db ?
CLK_STATUS db ?
D_STR  db 8,'?',8 dup('?'),'$'
T_STR  db 8,'?',8 dup('?'),'$'
;vars for gettime
HOURS db ?
MINUTES db ?
SECONDS db ?
DAYLIGHT db ?
RTC_STATUS db ?
;vars for convascii
CHAR_PACKED db ?
CHAR_H db ?
CHAR_L db ?
;----------------------------------------
.CODE 
MAIN PROC FAR
    MOV AX,@DATA
    MOV DS,AX
	MOV ES,AX
	;clear screen
	mov ax,0600h
	mov bh,07
	mov cx,0
	mov dx,184fh
	int 10h
	;set cursor 0,0
	mov ah,02
	mov bh,00
	mov dl,0
	mov dh,0
	int 10h
	;print background
	mov ah,09h
	mov bh,0
	mov al,20h
	mov cx,1600h
	mov bl,1fh
	int 10h


BEGIN:
	;print menu options
	mov al,0
	mov bh,0
	mov bl,024h	;1110_0000b
	mov cx,18
	mov dl,18
	mov dh,2
	mov bp, offset MENU_STR
	mov ah,13h
	int 10h
	;PRINT_STR OPT1
	mov al,1
	mov bh,0
	mov bl,0E4h	;1110_0000b
	mov cx,22
	mov dl,18
	mov dh,2
	mov bp, offset OPT1
	mov ah,13h
	int 10h
	;PRINT_STR OPT2
	mov al,1
	mov bh,0
	mov bl,0E4h	;1110_0000b
	mov cx,22
	mov dl,18
	mov dh,3
	mov bp, offset OPT2
	mov ah,13h
	int 10h
	;PRINT_STR OPT3
	mov al,1
	mov bh,0
	mov bl,0E4h	;1110_0000b
	mov cx,10
	mov dl,0
	mov dh,4
	mov bp, offset OPT3
	mov ah,13h
	int 10h
	;get menu option from user
	GET_CHARNE 
	mov USR_INPUT,AL
	
	;evaluate user input
	;look for Q/q
	cmp AL,'Q'
	je QUIT
	cmp AL,'q'
	je QUIT
	
	cmp AL,'D'
	je GETDATE
	cmp AL,'d'
	je GETDATE
	
	cmp AL,'T'
	je GETTIME
	cmp AL,'t'
	je GETTIME
	
	jmp BEGIN		;repeat loop
GETDATE: 
	call GET_DATE
	PRINT_STR DATE_STR
	mov bl,MONTH
	mov CHAR_PACKED,BL
	call CONV_ASCII
	mov [D_STR], AL
	mov [D_STR]+1, AH
	mov	[D_STR]+2, '/'
	mov bl,DAY
	mov CHAR_PACKED,bl
	call CONV_ASCII
	mov [D_STR]+3, AL
	mov [D_STR]+4, AH
	mov [D_STR]+5, '/'
	mov bl,YEAR
	mov CHAR_PACKED,bl
	call CONV_ASCII
	mov [D_STR]+6, AL
	mov [D_STR]+7, AH
	;PRINT_STR D_STR
	mov al,1
	mov bh,0
	mov bl,084h	;1110_0000b
	mov cx,8
	mov dl,32
	mov dh,6
	mov bp, offset D_STR
	mov ah,13h
	int 10h
	jmp BEGIN		;go back to menu loop
	
GETTIME:
	call GET_TIME	
	PRINT_STR TIME_STR
	mov bl,HOURS
	mov CHAR_PACKED,bl
	call CONV_ASCII
	mov [T_STR], AL
	mov [T_STR]+1, AH
	mov [T_STR]+2, ':'
	mov bl,MINUTES
	mov CHAR_PACKED,bl
	call CONV_ASCII
	mov [T_STR]+3, AL
	mov [T_STR]+4, AH
	mov [T_STR]+5, ':'
	mov bl,SECONDS
	mov CHAR_PACKED,bl
	call CONV_ASCII
	mov [T_STR]+6, AL
	mov [T_STR]+7, AH
	;
	mov al,1
	mov bh,0
	mov bl,0E4h	;1110_0000b
	mov cx,8
	mov dl,32
	mov dh,6
	mov bp, offset T_STR
	mov ah,13h
	int 10h
	jmp BEGIN		;return to menu loop
	
QUIT:
	MOV AH,4CH
    INT 21H
MAIN ENDP
     END MAIN
      