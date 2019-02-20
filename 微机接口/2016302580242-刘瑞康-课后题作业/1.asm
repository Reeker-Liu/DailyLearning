begin:  MOV AL,00H
up:		OUT 220H,AL
		INC AL
		CMP AL,0FFH
		JNZ up
		DEC AL
down:	OUT 220H,AL
		DEC AL
		CMP AL,19H
		JNZ down
		JMP begin