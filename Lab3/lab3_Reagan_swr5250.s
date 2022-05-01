.global sortDecendingInPlace
.global sumF64
.global prodF32
.global dotpF32
.global maxF32
.global absSumF64
.global sqrtSumF64
.global getDirection
.global getAddNo
.global getCity

.text

@extern void sortDecendingInPlace (int16_t x[], uint32_t count);
@extern double sumF64(double x[], uint32_t count);
@extern float prodF32(float x[], uint32_t count);
@extern float dotpF32(float x[], float y[], uint32_t count);
@extern float maxF32(float x[], uint32_t count);
@extern double absSumF64 (double x[], uint32_t count);
@extern double sqrtSumF64(double x[], uint32_t count);
@extern char getDirection (BUSINESS business[], uint32_t index);
@extern uint32_t getAddNo (BUSINESS business[], uint32_t index);
@extern char * getCity(BUSINESS business[], uint32_t index);

sortDecendingInPlace:
    PUSH {R4-R7, LR}
    MOV R7, R0
    MOV R6, R1
    MOV R5, #1 @set to one to test
        resetLoop:
            CMP R5, #0
            BEQ exitSort
            MOV R5, #0
            MOV R1, R6
            MOV R0, R7
            sortLoop:
                CMP R1, #1
                BEQ resetLoop
                LDRSH R2, [R0], #2
                LDRSH R3, [R0]
                SUB R1, R1, #1
                CMP R2, R3
                BLT switch
                B sortLoop

switch:
    SUB R0, R0, #2
    STRH R3, [R0], #2
    STRH R2, [R0]
    ADD R5, R5, #1
    B sortLoop

exitSort:
    POP {R4-R7, LR}
    BX LR

sumF64:
    MOV R2, #0
    VMOV D0, R2, R2
        sumLoop:
            CMP R1, #0
            BEQ exit
            VLDR.F64 D1, [R0]
            VADD.F64 D0, D0, D1
            SUB R1, R1, #1
            ADD R0, R0, #8
            B sumLoop
    BX LR

prodF32:
    MOV R2, #1
    VMOV.F32 S0, R2
    VCVT.F32.S32 S0, S0
        prodLoop:
            CMP R1, #0
            BEQ exit
            VLDR.F32 S1, [R0]
            VMUL.F32 S0, S0, S1
            SUB R1, R1, #1
            ADD R0, R0, #4
            B prodLoop
    BX LR

dotpF32:
    MOV R3, #0
    VMOV.F32 S0, R3
    VCVT.F32.S32 S0, S0
        dotLoop:
            CMP R2, #0
            BEQ exit
            VLDR.F32 S1, [R0]
            VLDR.F32 S2, [R1]
            VMLA.F32 S0, S1, S2
            ADD R0, R0, #4
            ADD R1, R1, #4
            SUB R2, R2, #1
            B dotLoop
    BX LR

maxF32:
    VLDR.F32 S0, [R0]
    ADD R0, R0, #4
    maxLoop:
        CMP R1, #0
        BEQ exit
        VLDR.F32 S1, [R0]
        VCMP.F32 S0, S1
        SUB R1, R1, #1
        BGT maxLoop
        VMOV S0, S1
        B maxLoop
    BX LR

absSumF64:
MOV R2, #0
    VMOV D0, R2, R2
        absLoop:
            CMP R1, #0
            BEQ exitAbs
            VLDR.F64 D1, [R0]
            VADD.F64 D0, D0, D1
            SUB R1, R1, #1
            ADD R0, R0, #8
            B absLoop
BX LR

exitAbs:
   VABS.F64 D0, D0
   BX LR 

sqrtSumF64:
MOV R2, #0
    VMOV D0, R2, R2
        sqrtLoop:
            CMP R1, #0
            BEQ exitSqrt
            VLDR.F64 D1, [R0]
            VADD.F64 D0, D0, D1
            SUB R1, R1, #1
            ADD R0, R0, #8
            B sqrtLoop
BX LR

exitSqrt:
    VSQRT.F64 D0, D0
    BX LR

getDirection:
    MOV R3, #120
    MUL R2, R1, R3
    ADD R0, R0, #44
    ADD R0, R0, R2
    LDRB R0, [R0]
    BX LR
BX LR

getAddNo:
    MOV R3, #120
    MUL R2, R1, R3
    ADD R0, R0, #40
	ADD R0, R0, R2
    LDR R0, [R0]
    BX LR

getCity:
    MOV R3, #120
    MUL R2, R1, R3
    ADD R0, R0, #78
	ADD R0, R0, R2
    BX LR

exit:
    BX LR
