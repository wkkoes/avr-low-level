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

.equ Digits_P = PORTB
.equ Segments_P = PORTD

//---Inicjalizacja sprzetu---//
ldi R18, 0b00011110
out DDRB, R18
out Digits_P, R18

ldi R18, 0b0111111
out DDRD, R18

//---0 shape---//
ldi R18, 0b00111111
out Segments_P, R18

MainLoop:
    //0
    ldi R18, 0b00000010
    out Digits_P, R18
    LOAD_CONST R16, R17, 5
    rcall DelayInMs

    //1
    ldi R18, 0b00000100
    out Digits_P, R18
    LOAD_CONST R16, R17, 5
    rcall DelayInMs

    //2
    ldi R18, 0b00001000
    out Digits_P, R18
    LOAD_CONST R16, R17, 5
    rcall DelayInMs

    //3
    ldi R18, 0b00010000
    out Digits_P, R18
    LOAD_CONST R16, R17, 5
    rcall DelayInMs

    rjmp MainLoop

DelayInMs:
    push R24
    push R25

    mov R24, R16
    mov R25, R17

Loop_DelayInMs:
    rcall DelayOneMs
    sbiw R24, 1
    brne Loop_DelayInMs

    pop R25
    pop R24
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
    
        


    