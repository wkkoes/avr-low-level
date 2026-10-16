/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

 //za³ozenia: wpisano np. ldi R22, 5 (5ms delay)
 Delay_ms:  
 ldi R21, 80 //outer counter

 Outer_Loop:
    ldi R20, 32 //inner counter

Inner_Loop:
    dec R20
    brne Inner_Loop

    nop
    dec R21
    brne Outer_Loop
    //1ms timeout expires here
    dec R22
    brne Delay_ms