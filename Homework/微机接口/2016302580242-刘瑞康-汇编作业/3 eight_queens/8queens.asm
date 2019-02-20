datasg segment
		dw 0						;for idx init positive, no use
		dw 0, 0, 0, 0, 0, 0, 0, 0	;the column number of queen for each row
IDX 	dw 0						;current index of row
CNT 	dw 0						;count of right solutios
VALID	dw 0
datasg ends


stacksg segment
	dw 0, 0, 0, 0, 0, 0, 0, 0		;use to save CX in recursion
stacksg ends
	
	
codesg segment
assume cs:codesg, ds:datasg, ss:stacksg
start:
		MOV AX, datasg
		MOV DS, AX		;init ds
		MOV AX, stacksg
		MOV SS, AX		;init ss
		MOV SP, 16		;init sp
		
		CALL APPEND
		
		MOV AX, CNT
        MOV DL,10
        DIV DL			;get each digit of the number
        OR AX,3030H		;to ascii
        MOV DX,AX		;DL has the higher digit
        MOV AH,2		;print digit
        INT 21H		
        MOV DL,DH		;DL has the lower digit
        INT 21H			;print digit
		
		MOV AX, 4c00H
		INT 21H

		
APPEND	PROC    NEAR
		PUSH CX
		ADD IDX, 2
		CMP IDX, 17
		JL nextidx
		INC CNT
		CALL PRINTARRAY
		JMP endappend
nextidx:
		MOV CX, 0
reappend:
		INC CX
		CMP CX, 8
		JA endappend
		MOV BX, IDX
		MOV DS:[BX], CX
		CALL VALIDATE
		CMP VALID, 0
		JNE reappend
		CALL APPEND		;recursion
		JMP reappend
endappend:	
		SUB IDX, 2
		POP CX
		RET
APPEND	ENDP


VALIDATE	PROC    NEAR
		MOV VALID, 0	;0-valid 1-invalid
		MOV DI, 0
revalidate:
		ADD DI, 2
		CMP DI, IDX
		JGE endvalidate
		MOV BX, IDX
		MOV DX, DS:[DI]
		CMP DX, DS:[BX]	;if array[idx] == array[DI]
		JE invalid
		MOV AX, IDX
		SUB AX, DI
		MOV SI, DS:[DI]
		SUB SI, DS:[BX]
		CMP DX, DS:[BX]
		JA keep
		NEG SI
keep:
		ADD SI, SI
		CMP AX, SI		;if (idx - DI) == abs(array[idx] - array[DI])
		JE invalid
		JMP revalidate
invalid:		
		INC VALID
endvalidate:	
        RET
VALIDATE	ENDP


PRINTARRAY	PROC    NEAR
		MOV BX, 0
rearray:
		ADD BX, 2
		MOV DX, DS:[BX]
		XOR DX, 3030H
        MOV AH,2	
        INT 21H		
		CMP BX, 16
		JNE rearray
		MOV DL, 0aH
		MOV AH,2
        INT 21H
        RET
PRINTARRAY	ENDP	

codesg ends

end start