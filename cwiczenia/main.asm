/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 

; ==========================================
; WEKTORY PRZERWAÑ
; ==========================================
.cseg 
.org 0          rjmp _main      ; Skok po resecie 
.org OC1Aaddr   rjmp _timer_isr ; Skok do obs³ugi przerwania Timera 1
.org PCIBaddr   rjmp _ExtInt_ISR ; Skok do obs³ugi przerwania z pinu PB0

; ==========================================
; MAKRA
; ==========================================
.macro LOAD_CONST
    ldi @0, low(@2)
    ldi @1, high(@2)
.endmacro

.macro SET_DIGIT
    ; Ksztalty
    mov R16, Digit_@0
    rcall DigitTo7segCode
    out Segments_P, R16
    ; Tranzystor
    ldi R18, (1 << (@0 + 1))
    out Digits_P, R18

    LOAD_CONST R16, R17, 5
    rcall DelayInMs
.endmacro

; ==========================================
; DEFINICJE SPRZÊTOWE I REJESTRY
; ==========================================
.equ Digits_P = PORTB
.equ Segments_P = PORTD

.def Digit_0 = R2
.def Digit_1 = R3
.def Digit_2 = R4
.def Digit_3 = R5

.def X_L = R16    
.def X_H = R17    
.def Y_L = R18    
.def Y_H = R19    
.def R_L = R16    
.def R_H = R17    
.def Q_L = R18    
.def Q_H = R19    
.def QCtrL = R24  
.def QCtrH = R25

.def Dig0 = R22
.def Dig1 = R23
.def Dig2 = R24
.def Dig3 = R25

.def PulseEdgeCtrL = R0
.def PulseEdgeCtrH = R1

; ==========================================
; PROGRAM G£ÓWNY (INICJALIZACJA)
; ==========================================
_main:
    ; --- Porty ---
    ldi R18, 0b00011110
    out DDRB, R18
    out Digits_P, R18

    ldi R18, 0b01111111
    out DDRD, R18

    ; --- Wyzerowanie licznika ---
    clr PulseEdgeCtrL
    clr PulseEdgeCtrH

    ; --- Inicjalizacja Timera 1 (CTC, Preskaler 256, 25600 cykli) ---
    ldi R16, high(25600)
    out OCR1AH, R16
    ldi R16, low(25600)
    out OCR1AL, R16

    ldi R16, (1<<WGM12) | (1<<CS12)
    out TCCR1B, R16

    ldi R16, (1<<OCIE1A)
    out TIMSK, R16

    ; --- Inicjalizacja Przerwañ Zewnêtrznych---
    ldi R16, (1<<PCIE)      ; wlaczone przerwania od zmiany stanu pinów (Pin Change Interrupt Enable)
    out GIMSK, R16         
    
    ldi R16, (1<<PCINT0)    
    out PCMSK, R16         

    ; --- Globalne odblokowanie przerwañ ---
    sei

; ==========================================
; PÊTLA G£ÓWNA
; ==========================================
MainLoop:
    ; 1. Pobranie aktualnego stanu licznika i konwersja na cyfry
    mov R16, PulseEdgeCtrL
    mov R17, PulseEdgeCtrH
    rcall NumberToDigits

    ; 2. Zapis cyfr do rejestrów wyœwietlacza
    mov Digit_0, R16        
    mov Digit_1, R17
    mov Digit_2, R18
    mov Digit_3, R19

    ; 3. Zaœwiecenie segmentów
    SET_DIGIT 0
    SET_DIGIT 1
    SET_DIGIT 2
    SET_DIGIT 3
    
    rjmp MainLoop
    
; ==========================================
; PROCEDURA OBS£UGI PRZERWANIA (ISR)
; ==========================================
; ==========================================
; PRZERWANIE ZEWNÊTRZNE (Pin PB0) 
; ==========================================
_ExtInt_ISR:
    push R16
    push R17
    in R16, SREG
    push R16

    
    inc PulseEdgeCtrL       
    brne End_ExtInt
    inc PulseEdgeCtrH

End_ExtInt:
    
    pop R16
    out SREG, R16           
    pop R17
    pop R16
    reti

; ==========================================
; PRZERWANIE TIMERA 
; ==========================================
_timer_isr:
    reti ;                    

; ==========================================
; PODPROGRAMY
; ==========================================
NumberToDigits:
    ldi Y_L, low(1000)
    ldi Y_H, high(1000)
    rcall Divide
    mov Dig0, Q_L 

    ldi Y_L, low(100)
    ldi Y_H, high(100)
    rcall Divide
    mov Dig1, Q_L 

    ldi Y_L, low(10)
    ldi Y_H, high(10)
    rcall Divide
    mov Dig2, Q_L 

    mov Dig3, R_L

    mov R16, Dig0
    mov R17, Dig1
    mov R18, Dig2
    mov R19, Dig3
    ret

Divide:
    push QCtrL
    push QCtrH

    ldi QCtrL, 0
    ldi QCtrH, 0

DivLoop:
    cp X_L, Y_L
    cpc X_H, Y_H
    brcs DivDone

    sub X_L, Y_L
    sbc X_H, Y_H
    adiw QCtrL, 1
    rjmp DivLoop

DivDone:
    mov Q_L, QCtrL
    mov Q_H, QCtrH

    pop QCtrH
    pop QCtrL
    ret

DelayInMs:
    push R24
    push R25
    mov R24, R16
    mov R25, R17
Loop_DelayInMs:
    rcall DelayOneMs
    sbiw R24, 1
    brne Loop_DelayInMs
    pop R25
    pop R24
    ret

DelayOneMs:
    push R24
    push R25
    LOAD_CONST R24, R25, 2000
Inner_16bit:
    sbiw R24, 1
    brne Inner_16bit
    pop R25
    pop R24
    ret

DigitTo7segCode:
    push R30
    push R31
    push R17
    ldi R30, low(SegTable<<1)
    ldi R31, high(SegTable<<1)
    add R30, R16
    ldi R17, 0
    adc R31, R17
    lpm R16, Z
    pop R17
    pop R31
    pop R30
    ret

SegTable:
    ;   0           1           2           3           4           5           6           7           8           9
    .db 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111