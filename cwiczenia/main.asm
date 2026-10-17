/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

.macro LOAD_CONST
ldi R16, low(@0)
ldi R17, high(@0)
.endmacro

LOAD_CONST 500
