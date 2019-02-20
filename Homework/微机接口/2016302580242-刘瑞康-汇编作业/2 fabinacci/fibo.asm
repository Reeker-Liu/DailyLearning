datasg segment
	dw 0, 1, 0, 1
	; 000 001, 000 001
datasg ends

codesg segment
assume cs:codesg, ds:datasg
start:
		MOV AX, datasg
		MOV DS, AX		;init ds
		
		MOV BX, 0
re:		MOV DI, DS:[0]		;di higher 3-bit
		MOV SI, DS:[2]		;si lower 3-bit
		MOV CX, DI
		CALL PRINT
		MOV CX, SI
		CALL PRINT
		CALL PRINTNEWLINE
		MOV AX, DS:[4]
		MOV DS:[0], AX
		MOV AX, DS:[6]
		MOV DS:[2], AX
		ADD DI, DS:[4]
		ADD SI, DS:[6]
		
		CMP SI,1000		;if need carry
		JB uncarry
		SUB SI, 1000
		INC DI
		
uncarry:MOV DS:[4], DI
		MOV DS:[6], SI
		
		INC BX
		CMP BX, 30
		JNE re
		
		MOV AX, 4c00H
		INT 21H
		
PRINT	PROC    NEAR
		;CX has the current 3-bit to print
		MOV AX, CX
        MOV DL,100
        DIV DL		;get each digit of the number
        OR AL,30H	;to ascii
        MOV DX,AX	;DL has the higher digit, DH has the AH
        MOV AH,2	;print digit
        INT 21H		
		
		MOV AL, DH
		XOR AH, AH	;clear AH
		MOV DL, 10
		DIV DL		;get each digit of the number
        OR AX,3030H	;to ascii
        MOV DX,AX	;DL has the higher digit
        MOV AH,2	;print digit
        INT 21H		
        MOV DL,DH	;DL has the lower digit
        INT 21H		;print digit
		
        RET
PRINT	ENDP	

PRINTNEWLINE	PROC    NEAR
		MOV DL,0aH	; print newline
        INT 21H
		RET
PRINTNEWLINE	ENDP	

codesg ends

end start