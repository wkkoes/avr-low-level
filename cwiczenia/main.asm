/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

 //we assume ldi R22, 5 for 5 ms delay

 //---start 1ms---//
 Wait_ms:
    //2000==>0x7D0
    ldi R24, $D0
    ldi R25, $07

Inner_16bit:
    sbiw R24, 1
    brne Inner_16bit
//---end 1ms---//
    dec R22
    brne Wait_ms

    