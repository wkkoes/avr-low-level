/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

MainLoop:
    ldi R22, 5
    rcall Delay_ms

    nop
    rjmp MainLoop

Delay_ms:
    rcall DelayOneMs
    dec R22
    brne Delay_ms

    ret
DelayOneMs:
    ldi R24, $D0
    ldi R25, $07
    
Inner_16bit:
    sbiw R24, 1
    brne Inner_16bit
    
    ret  