/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 
 END_Loop:   
 ldi R21, 10 //outer counter

 Outer_Loop:
    ldi R20, 50 //inner counter

Inner_Loop:
    nop
    dec R20
    brne Inner_Loop

    dec R21
    brne Outer_Loop
    rjmp END_Loop