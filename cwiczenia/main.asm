/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 
 
 .macro SET_DIGIT
 //ksztalty
    mov R16, Digit_@0
    rcall DigitTo7segCode
    out Segments_P, R16
 //tranzystor
    ldi R18, (1 << (@0 + 1))
    out Digits_P, R18

    LOAD_CONST R16, R17, 5
    rcall DelayInMs
 .endmacro


 .macro LOAD_CONST
    ldi @0, low(@2)
    ldi @1, high(@2)
.endmacro

.equ Digits_P = PORTB
.equ Segments_P = PORTD

.def Digit_0 = R2
.def Digit_1 = R3
.def Digit_2 = R4
.def Digit_3 = R5

//---Inicjalizacja sprzetu---//
ldi R18, 0b00011110
out DDRB, R18
out Digits_P, R18

ldi R18, 0b01111111
out DDRD, R18

//test 6967
ldi R18, 6
mov Digit_0, R18

ldi R18,9
mov Digit_1, R18

ldi R18, 6
mov Digit_2, R18

ldi R18, 7
mov Digit_3, R18

MainLoop:
   SET_DIGIT 0
   SET_DIGIT 1
   SET_DIGIT 2
   SET_DIGIT 3
   
   inc Digit_3
   ldi R16, 10
   cp Digit_3, R16
   brne SkipReset

   clr Digit_3

   inc Digit_2
   cp Digit_2, R16
   brne SkipReset

   clr Digit_2

   inc Digit_1
   cp Digit_1, R16
   brne SkipReset

   clr Digit_1

   inc Digit_0
   cp Digit_0, R16
   brne SkipReset

   clr Digit_0

SkipReset:
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

DigitTo7segCode:
    push R30
    push R31
    push R17

    ldi R30, low(SegTable<<1)
    ldi R31, high(SegTable<<1)

    add R30, R16
    ldi R17, 0
    adc R31, R17

    lpm R16, Z

    pop R17
    pop R31
    pop R30
    ret

 SegTable:
    ;   0           1           2           3           4           5           6           7           8           9
    .db 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111

