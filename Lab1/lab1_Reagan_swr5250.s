.global add64
.global sub64
.global minU16
.global minS32
.global isLessThanU16
.global isLessThanS16
.global shiftLeftU16
.global shiftU32
.global shiftS8
.global isEqualU32
.global isEqualS8


.text

add64:
	ADDS R0, R0, R1
	MOV R1, #0
	ADC R1, R1, #0
	BX LR

sub64:
	SUBS R0, R0, R2
	SBC R1, R1, R3
	BX LR

minU16:
	CMP R0, R1
	BLT END
	MOV R0, R1
	BX LR
	
minS32:
	CMP R0, R1
	BLT END
	MOV R0, R1
	BX LR
	
isLessThanU16:
	CMP R0, R1
	MOV R0, #1
	BLT END
	MOV R0, #0
	BX LR
	
isLessThanS16:
	CMP R0, R1
	MOV R0, #1
	BLT END
	MOV R0, #0
	BX LR
	
shiftLeftU16:
	LSL R0, R0, R1
	BX LR
	
shiftU32:
	CMP R1, #0
	BLT shiftRight
	LSL R0, R0, R1
	BX LR

shiftS8:
	CMP R1, #0
	BLT shiftRight
	LSL R0, R0, R1
	BX LR

isEqualU32:
	CMP R0, R1
	MOV R0, #1
	BEQ END
	MOV R0, #0
	BX LR
	
isEqualS8:
	CMP R0, R1
	MOV R0, #1
	BEQ END
	MOV R0, #0
	BX LR

END:
	BX LR

shiftRight:
	NEG R1, R1
	LSR R0, R0, R1
	BX LR
	
