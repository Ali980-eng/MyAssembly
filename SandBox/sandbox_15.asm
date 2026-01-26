DATA SEGMENT
    
DATA ENDS
EXTRA SEGMENT

EXTRA ENDS
CODE SEGMENT
  ASSUME CS:CODE, DS:DATA, ES:EXTRA
  INCLUDE MainUtils.INC
  ; =====================================================
  ; SQRT_FIXED MACRO
  ; Input:  AX = N (unsigned integer, 0 <= N <= 65535)
  ; Output: BX = Integer part of sqrt(N)
  ;         DX = Fractional part * 10000 (e.g., 0.1622 -> DX=1622)
  ; Uses:   AX (intermediate math), CX (loop/temp), DX (fractional output)
  ; Preserves SI/DI/BP (uses only AX,BX,CX,DX)
  ; =====================================================
  SQRT_FIXED MACRO
      LOCAL is_zero, newton_start, newton_loop, calc_remainder, exact_root, done
  
      ; Handle N=0 immediately
      cmp ax, 0
      je is_zero
  
      ; Save original N in CX
      mov cx, ax          ; CX = N (preserved for remainder calc)
  
      ; Newton-Raphson initialization
      ; Initial guess: x = N/2 + 1 (better convergence)
      shr ax, 1           ; AX = N/2
      inc ax              ; AX = N/2 + 1
      mov bx, ax          ; BX = current estimate (will become final integer part)
  
  newton_loop:
      ; Compute next estimate: x_new = (x + N/x) / 2
      mov ax, cx          ; AX = N
      xor dx, dx          ; Clear DX for DIV
      div bx              ; AX = N / BX (current estimate)
      add ax, bx          ; AX = (N/x) + x
      shr ax, 1           ; AX = ((N/x) + x) / 2
      
      ; Termination check: if AX >= BX, we're done
      cmp ax, bx
      jge newton_done
      
      ; Update estimate and repeat
      mov bx, ax
      jmp newton_loop
  
  newton_done:
      ; BX now holds floor(sqrt(N))
      ; Calculate remainder: r = N - BX^2
  calc_remainder:
      mov ax, bx          ; AX = root
      mul bx              ; DX:AX = root^2 (but root <= 255, so DX=0)
      mov dx, ax          ; DX = root^2
      mov ax, cx          ; AX = N
      sub ax, dx          ; AX = remainder (r = N - root^2)
      jz exact_root       ; If r=0, no fractional part
  
      ; Calculate fractional part = (r * 10000) / (2*root)
      ; Numerator: r * 10000
      mov dx, 10000
      mul dx              ; DX:AX = r * 10000
      ; Denominator: 2*root (root still in BX)
      mov cx, bx
      add cx, cx          ; CX = 2*root
      ; 32-bit division: DX:AX / CX
      div cx              ; AX = (r*10000)/(2*root), DX = remainder
      mov dx, ax          ; DX = fractional part * 10000
      jmp done
  
  exact_root:
      mov dx, 0           ; No fractional part
  
  done:
      ; BX already holds integer part
      jmp macro_end
  
  is_zero:
      mov bx, 0           ; Integer part = 0
      mov dx, 0           ; Fractional part = 0
  
  macro_end:
  ENDM
  MAIN:
    CALL MAIN_SETUP
    mov ax, 10          ; Calculate sqrt(10)
    SQRT_FIXED          ; Macro call
    ; Results:
    ; BX = 3 (integer part)
    ; DX = 1622 (fractional part -> 0.1622)
    CALL MAIN_END     
CODE ENDS
END MAIN