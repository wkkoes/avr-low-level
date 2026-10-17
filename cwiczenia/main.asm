/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

MainLoop:
rcall DelayNCycles ;
rjmp MainLoop
DelayNCycles: ;zwyk³a etykieta
nop
nop
nop
ret

//cycle measurement:
//cycles=rcall(3)+ 3*nop(3)+ ret(4) = 10
    