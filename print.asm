; ------------------------------------ PrintMsg ------------------------------------
;
;    Prints a message given by the HL register, taking into account 
;    several parameters written in the DEFB instruction:
;    
;    message DEFB {Row}(Decimal), {Column}(Decimal), {Color Attributes}(%FBPP PIII)
;            DEFM 'Hello World', $00
;   
; ----------------------------------------------------------------------------------

PrintMsg:
    LD A, $18
    SUB (HL)
    LD B, A
    INC HL                                           
    LD A, $21
    SUB (HL)
    LD C, A
    INC HL
    PUSH HL
    CALL CL_SET                                           
    POP HL
    LD A, (HL)
    LD (ATTR_T), A
    INC HL
PrintLoop:
    LD A, (HL)                                              
    OR A
    JR Z, EndLoop
    RST $10
    INC HL
    JR PrintLoop
EndLoop:
    RET
