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

ldi R18, 0b01111111
out DDRD, R18

//0,1,2,3 / feature dla cwiczenia 34
ldi R18, 0b00111111  ; Cyfra "0" dla pozycji 0
mov R2, R18

ldi R18, 0b00000110  ; Cyfra "1" dla pozycji 1
mov R3, R18

ldi R18, 0b01011011  ; Cyfra "2" dla pozycji 2
mov R4, R18

ldi R18, 0b01001111  ; Cyfra "3" dla pozycji 3
mov R5, R18

MainLoop:
    //0
    out Segments_P, R2
    ldi R18, 0b00000010
    out Digits_P, R18
    LOAD_CONST R16, R17, 5
    rcall DelayInMs

    //1
    out Segments_P, R3
    ldi R18, 0b00000100
    out Digits_P, R18
    LOAD_CONST R16, R17, 5
    rcall DelayInMs

    //2
    out Segments_P, R4
    ldi R18, 0b00001000
    out Digits_P, R18
    LOAD_CONST R16, R17, 5
    rcall DelayInMs

    //3
    out Segments_P, R5
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
    
        


    