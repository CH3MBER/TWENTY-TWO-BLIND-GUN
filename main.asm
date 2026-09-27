    ORG $8000

    ATTR_P EQU $5C8D                                        ; Format: FLASH, BRIGHT, PAPER, INK (FBPP PIII)
    ATTR_T EQU $5C8F
    CL_ALL EQU $0DAF
    CL_SET EQU $0DD9

    ; MAIN MENU
    msgTitle DEFB 10, 5, %01000111                          ; Row, Column, Attributes ; BLACK paper WHITE ink
             DEFM 'TWENTY TWO: Blind Gun', $00
    msgPressZero DEFB 13, 8, %10000110                      ; BLACK paper and FLASH YELLOW ink
                 DEFM 'Press 0 to Play', $00
    msgPressFive DEFB 16, 7, %00000111                      ; BLACK paper and WHITE ink
                 DEFM 'Press 5 for Input', $00
    ; CONTROLS
    msgControlsQ DEFB 7, 9, %00000111
                 DEFM 'Q - Move Up', $00
    msgControlsA DEFB 9, 9, %00000111
                 DEFM 'A - Move Down', $00
    msgControlsO DEFB 11, 9, %00000111
                 DEFM 'O - Move Left', $00
    msgControlsP DEFB 13, 9, %00000111
                 DEFM 'P - Move Right', $00    
    INCLUDE "print.asm"

; ================================
;         START OF PROGRAM      
; ================================

StartProgram:

    XOR A                                                   ; Turn the border BLACK. (XOR A will always make it $00)
    OUT ($FE), A



MainMenu:
    LD A, %00000111                                         ; Add Permanent Color Attributes                                
    LD (ATTR_P), A
    CALL CL_ALL                                             ; Clear the whole display area    
    LD HL, msgTitle
    CALL PrintMsg
    LD HL, msgPressZero
    CALL PrintMsg
    LD HL, msgPressFive
    CALL PrintMsg

MenuLoop:
    LD A, $EF                                               ; Read the "0" key
    IN A, ($FE)
    BIT 0, A 
    JR Z, StartGame
    LD A, $F7                                               ; Read the "5" key
    IN A, ($FE)
    BIT 4, A 
    JR Z, Controls
    JR MenuLoop
Controls:
    LD A, $01
    OUT ($FE), A
    CALL CL_ALL
    LD HL, msgControlsQ
    CALL PrintMsg
    LD HL, msgControlsA
    CALL PrintMsg
    LD HL, msgControlsO
    CALL PrintMsg
    LD HL, msgControlsP
    CALL PrintMsg
Loop:   
    LD A, $EF                                               ; Read the "0" key
    IN A, ($FE)
    BIT 0, A 
    JR Z, MainMenu
    JR Loop 
StartGame:
    LD A, $02
    OUT ($FE), A
    JR MenuLoop 



    END StartProgram