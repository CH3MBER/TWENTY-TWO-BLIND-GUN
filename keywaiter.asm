; -------------------------- KeyWait ---------------------------------
;
;    Waits for no key to be pressed to avoid accidental screen
;    changes
;   
;    This routine changes register A and Flags.
;
; ---------------------------------------------------------------------

KeyWait:
    XOR A                                                    ; Read ANY key
    IN A, ($FE)
    HALT
    OR $E0
    CP $FF
    JR NZ, KeyWait
    RET
