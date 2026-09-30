; -------------------------- KeyWait ---------------------------------
;
;    Waits for no key to be pressed to avoid accidental screen
;    changes
;   
;    This routine changes the register A.
;
; ---------------------------------------------------------------------

KeyWait:
    LD A, $00                                               ; Read ANY key
    IN A, ($FE)
    OR $E0
    SUB $FF
    JR NZ, KeyWait
    RET
