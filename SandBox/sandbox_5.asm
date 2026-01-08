ORG 100H
    START:
        JMP LEN
        JMP LOWER_CASE
        JMP END
    LEN:
        JMP RESET_ALL
        MOV BX, OFFSET MSG
        MOV AX, [BX]
        L1:
            CMP AX, 0AH
            JNZ L2
        RET
    L2:
        INC CX
        JMP L1
    LOWER_CASE:
        MOV BX, OFFSET MSG
        MOV AX, [BX]
        L3:
            CMP AX, 20H
            JNZ CAST_LOW
        LOOP L3
        RET
    CAST_LOW:
        SUB AX, 20H
        RET
    RESET_ALL:
        XOR AX, AX
        XOR BX, BX
        XOR CX, CX
        XOR DX, DX
        RET    
    END:
HLT
MSG DB "HELLO WORLD", 0AH