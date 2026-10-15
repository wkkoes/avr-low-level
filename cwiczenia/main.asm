/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 
 //Cycles = 3*R20
Inf_Loop:
    ldi R20, 10
    nop
    nop
    nop
    nop
    nop
    Decrementation: 
        nop
        nop
        dec R20
        brne Decrementation
        rjmp Inf_Loop

