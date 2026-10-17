/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 
 
 MainLoop:
    ldi R16, 5          ; Wrzucamy cyfrê 5
    rcall SquareNumber  ; Wo³amy podprogram
    
    ; W tym miejscu rejestr R16 powinien mieæ wartoœæ 25 (w HEX: $19)
    nop
    rjmp MainLoop

 SquareNumber:
    push R30
    push R31
    push R17

    ldi R30, low(SquareTable<<1)
    ldi R31, high(SquareTable<<1)

    add R30, R16
    ldi R17, 0
    adc R31, R17

    lpm R16, Z

    pop R17
    pop R31
    pop R30
    ret

 SquareTable:
    .db 0,1,4,9,16,25,36,49,64,81


    
        


    