/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 
 END_Loop:   
 ldi R21, 100 //outer counter

 Outer_Loop:
    ldi R20, 32 //inner counter

Inner_Loop:
    dec R20
    brne Inner_Loop

    nop
    dec R21
    brne Outer_Loop
    rjmp END_Loop