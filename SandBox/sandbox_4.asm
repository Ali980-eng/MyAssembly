DATA SEGMENT
    msg DB "Hello world", 0Ah
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    XOR CX, CX        
    MOV SI, OFFSET msg 
LOOP_READ:
    MOV AL, [SI] 
    CMP AL, 0Ah       
    JE DONE           
    INC CX            
    INC SI            
    JMP LOOP_READ
DONE:
    MOV AH, 4Ch
    INT 21h
CODE ENDS
END START
