    ORG $8000

    ATTR_P EQU $5C8D                                        ; Format: FLASH, BRIGHT, PAPER, INK (FBPP PIII)
    ATTR_T EQU $5C8F
    CL_ALL EQU $0DAF
    CL_SET EQU $0DD9

    msgTitle DEFB 10, 5, %01000111                          ; Row, Column, Attributes ; BLACK paper WHITE ink
             DEFM 'TWENTY TWO: Blind Gun', $00
    msgPressZero DEFB 13, 8, %10000110                      ; BLACK paper and FLASH YELLOW ink
                 DEFM 'Press 0 to Play', $00
    msgPressFive DEFB 16, 7, %00000111                      ; BLACK paper and WHITE ink
                 DEFM 'Press 5 for Input', $00
    INCLUDE "print.asm"

; ================================
;         START OF PROGRAM      
; ================================

StartProgram:

    LD A, $00                                               ; Turn the border BLACK
    OUT ($FE), A




; ======= Add Permanent Color Attributes =======

    LD A, %00000111                                        
    LD (ATTR_P), A
    CALL CL_ALL                                             ; Clear the whole display area    

; ======= "TWENTY TWO: Blind Gun" Title Print =======

    LD HL, msgTitle
    CALL PrintMsg

; ======= "Press 0 to Start" Print =======

    LD HL, msgPressZero
    CALL PrintMsg

; ======= "Press 5 for Controls" Print =======

    LD HL, msgPressFive
    CALL PrintMsg

InfLoop:
    LD A, $EF                                               ; Read the "0" key
    IN A, ($FE)
    BIT 0, A 
    JR Z, StartGame
    LD A, $F7                                               ; Read the "5" key
    IN A, ($FE)
    BIT 4, A 
    JR Z, Controls
    JR InfLoop
Controls:
    LD A, $01
    OUT ($FE), A 
    JR InfLoop
StartGame:
    LD A, $02
    OUT ($FE), A
    JR InfLoop 



    END StartProgram