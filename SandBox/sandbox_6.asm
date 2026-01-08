;Convert the capital letters -
; - to small letters and the -
; - small to capital in string STR.
ORG 100H
  MOV DI, OFFSET STR
  XOR CX, CX
  JMP LEN
  A1: MOV DI, OFFSET STR
  L1:
    JMP UPPER
    A2:
    CMP DX, 3
    JZ CAST_UPPER
    JNZ CAST_LOWER
    A3: INC DI  
  LOOP L1
  JMP END
  CAST_UPPER:
    SUB [DI], 20H
    JMP A3
  CAST_LOWER:
    ADD [DI], 20H
    JMP A3  
  LEN:
    CMP [DI], 10H
    JZ A1
    INC DI
    INC CX
    JMP LEN
  UPPER:
    CMP [DI], 5AH
    JBE TRUE
    JA FALSE
    TRUE:
      MOV DL, 7
      JMP A2
    FALSE:
      MOV DL, 3
      JMP A2
  END:
    MOV DI, OFFSET STR
    MOV CX, 8H
    L2:
      MOV AL, [DI]
      INC DI  
    LOOP L2
RET
STR DB "ABcdEFgh", 10H