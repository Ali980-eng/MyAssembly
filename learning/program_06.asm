MOV CX, 1234H
MOV AL, CH
MOV [BX], CX
MOV DL, [BX]
MOV AH, [BX + 1]
XCHG AX, DX
;Load 34CD H in to SS register and copy the content
;of the memory loction A300 H and load result in ES?
MOV BX, 34CDH
MOV SS, BX
MOV [0A300H], SS
MOV ES, [0A300H]
RET
