/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

MainLoop:
    ldi R24, 5
    rcall Delay_ms

    nop
    rjmp MainLoop

Delay_ms:
    rcall DelayOneMs
    dec R24
    brne Delay_ms
    ret

DelayOneMs:
    sts $60, R24 //kopia zapasowa: wartosc R24,5 trafia do RAM adres 0x60
    ldi R24, $D0 
    ldi R25, $07
    
Inner_16bit:
    sbiw R24, 1
    brne Inner_16bit

    lds R24, $60 //przywrocenie kopii
    ret  