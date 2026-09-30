; -------------------------- KeyWait ---------------------------------
;
;    Waits for no key to be pressed to avoid accidental screen
;    changes
;   
;    This routine changes register A and Flags.
;
; ---------------------------------------------------------------------

KeyWait:
    HALT 
    XOR A                                                    ; Read ANY key
    IN A, ($FE)
    OR $E0
    CP $FF
    JR NZ, KeyWait
    RET
