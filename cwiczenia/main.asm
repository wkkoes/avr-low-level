/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

MainLoop:
    rcall LVL_1 
    rjmp MainLoop

LVL_1:
    nop 
    rcall LVL_2
    nop
    ret ;return to main loop

LVL_2:
    nop
    nop
    ret ;return to level 1 
    