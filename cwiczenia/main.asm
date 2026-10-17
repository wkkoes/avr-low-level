/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 
 
 MainLoop:
    ldi R16, 5          ; testowo dajemy 5, powinno byc R16 
    rcall DigitTo7segCode  
    
    nop
    rjmp MainLoop

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


    
        


    