/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

 ldi R16, 1 //register holding value 1 to add
 ldi R17, 0 //register holding value 0, handle carry

 //we assume ldi R22, 5 for 5 ms delay

 //---start 1ms---//
 Wait_ms:
    //65536 - 2000 = 63536 (HEX: 0xF830)
    ldi R24, $30
    ldi R25, $F8

Inner_16bit:
    add R24, R16
    adc R25, R17
    brcc Inner_16bit //branch if carry cleared
//---end 1ms---//
    dec R22
    brne Wait_ms

    