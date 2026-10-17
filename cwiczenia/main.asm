/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

MainLoop:
    ldi R16, $F4
    ldi R17, $01
    rcall DelayInMs
    rjmp DelayInMs //WAZNE

DelayInMs:
    push R16
    push R17

Loop_DelayInMs:
    rcall DelayOneMs
    //sbiw R16, 1 - nie zadzia?a, bo sbiw dziala na 4 najwyzszych parach rejestrow, trzeba odjac korzystajac z flagi carry
    subi R16, 1
    sbci R17, 0
    brne Loop_DelayInMs

    pop R17
    pop R16
    ret

DelayOneMs:
    push R24
    push R25

    ldi R24, $D0
    ldi R25, $07

Inner_16bit:
    sbiw R24, 1
    brne Inner_16bit

    pop R25
    pop R24

    ret