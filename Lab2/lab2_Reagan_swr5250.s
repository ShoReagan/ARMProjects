.global stringCopy
.global stringCat
.global sumS8
.global sumS16
.global sumU32_64
.global countNegative
.global countNonNegative
.global countMatches
.global returnMax
.global returnMin

.text

@ extern void stringCopy(char* strTo, char* strFrom); // copies strFrom to strTo
@ extern void stringCat(char* strFrom, char* strTo); // adds strFrom to end of strTo
@ extern int8_t sumS8(int8_t x[], int32_t count);
@ extern int16_t sumS16(int16_t x[], int32_t count);
@ extern uint64_t sumU32_64(uint32_t x[], uint32_t count);
@ extern uint32_t countNegative (int16_t x[], uint32_t count);
@ extern uint32_t countNonNegative (int8_t x[], uint32_t count);
@ extern uint32_t countMatches(char str[], char toMatch);
@ extern int16_t returnMax(int16_t x[], uint32_t count);
@ extern int16_t returnMin(int16_t x[], uint32_t count);

stringCopy:
    stringCopyLoop:
        LDRB R2, [R1], #1
        CMP R2, #0
        BEQ exit
        STRB R2, [R0], #1
        B stringCopyLoop

stringCat:
    MOV R2, R1
    stringCatLoop1:
        LDRB R3, [R2], #1
        CMP R3, #0
        BNE stringCatLoop1
        SUB R2, R2, #1
    stringCatLoop2:
        LDRB R3, [R0], #1
        STRB R3, [R2], #1
        CMP R3, #0
        BNE stringCatLoop2
        MOV R0, R2
        BEQ exit

sumS8:
    MOV R2, R0
    MOV R0, #0
    sumS8Loop:
        CMP R1, #0
        BEQ exit
        LDRB R3, [R2], #1
        ADD R0, R0, R3
        SUB R1, R1, #1
        B sumS8Loop


sumS16:
    MOV R2, R0
    MOV R0, #0
    sumS16Loop:
        CMP R1, #0
        BEQ exit
        LDRH R3, [R2], #2
        ADD R0, R0, R3
        SUB R1, R1, #1
        B sumS16Loop

sumU32_64:
    MOV R2, R0
    MOV R4, R1
    MOV R0, #0
    MOV R1, #0
    sumS32Loop:
        CMP R4, #0
        BEQ exit
        LDR R3, [R2], #4
        ADDS R0, R0, R3
        ADC R1, R1, #0
        SUB R4, R4, #1
        B sumS32Loop

countNegative:
    MOV R2, R0
    MOV R0, #0
    countNegativeLoop:
        CMP R1, #0
        BEQ exit
        LDRSH R3, [R2], #2
        SUB R1, R1, #1
        CMP R3, #0
        BGE countNegativeLoop
        ADD R0, R0, #1
        B countNegativeLoop

countNonNegative:
    MOV R2, R0
    MOV R0, #0
    countNonNegativeLoop:
        CMP R1, #0
        BEQ exit
        LDRSB R3, [R2], #1
        SUB R1, R1, #1
        CMP R3, #0
        BLT countNonNegativeLoop
        ADD R0, R0, #1
        B countNonNegativeLoop


countMatches:
    MOV R2, R0
    MOV R0, #0
    countMatchesLoop:
        LDRB R3, [R2], #1
        CMP R3, #0
        BEQ exit
        CMP R3, R1
        BNE countMatchesLoop
        ADD R0, R0, #1
        B countMatchesLoop

returnMax:
    MOV R2, R0
    LDRSH R0, [R2]
    returnMaxLoop:
        CMP R1, #0
        BEQ exit
        LDRSH R3, [R2], #2
        SUB R1, R1, #1
        CMP R0, R3
        BGT returnMaxLoop
        MOV R0, R3
        B returnMaxLoop

returnMin:
    MOV R2, R0
    LDRSH R0, [R2]
    returnMinLoop:
        CMP R1, #0
        BEQ exit
        LDRSH R3, [R2], #2
        SUB R1, R1, #1
        CMP R0, R3
        BLT returnMinLoop
        MOV R0, R3
        B returnMinLoop

exit:
    BX LR

