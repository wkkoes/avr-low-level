/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

.macro LOAD_CONST
    ldi @0, low(@2)
    ldi @1, high(@2)
.endmacro

ldi R18, 0b00011110
out DDRB, R18

MainLoop:
    ldi R18, 0b00011110
    out PORTB, R18

    LOAD_CONST R16, R17, 500 //delay 500ms
    rcall DelayInMs
    rjmp MainLoop

DelayInMs:
    push R16
    push R17

Loop_DelayInMs:
    rcall DelayOneMs
    subi R16, 1
    sbci R17, 0
    brne Loop_DelayInMs

    pop R17
    pop R16
    ret

DelayOneMs:
    push R24
    push R25

    LOAD_CONST R24, R25, 2000

Inner_16bit:
    sbiw R24, 1
    brne Inner_16bit

    pop R25
    pop R24
    ret
    
        


    