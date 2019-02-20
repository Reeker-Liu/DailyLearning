codesg segment
assume cs:codesg
start:	
		MOV CX, 2	;init the number to check
outer:	
		MOV BX, 1	;init the divisor
inner:	
		INC BX		;divisor from 2 to the number
		MOV AX, CX	;move to AX for dividing
		DIV BL
		CMP AH, 0	;if remainder is 0, break loop
		JE break
		CMP BX, CX
		JNE inner
break:	
		CMP BX, CX	;after inner loop, check the end reason
		JNE nextd
		CALL PRINT	;if ends because of remainder is 0, print the number
nextd:	
		CMP CX, 100
		JE finish
		INC CX
		JMP outer
finish:
		MOV AX, 4c00H
		INT 21H
		
PRINT	PROC    NEAR
		MOV AX, CX
        MOV DL,10
        DIV DL		;get each digit of the number
        OR AX,3030H	;to ascii
        MOV DX,AX	;DL has the higher digit
        MOV AH,2	;print digit
        INT 21H		
        MOV DL,DH	;DL has the lower digit
        INT 21H		;print digit
        MOV DL,20H	; print space
        INT 21H
        RET
PRINT	ENDP

codesg ends
end start