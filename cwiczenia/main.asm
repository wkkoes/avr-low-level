/*
 * kolos
 *
 *  Created: 15.10.2026 12:00:41
 *   Author: Wiktor
 */ 
 
 .def X_L = R16    ; Dzielna (m³odszy bajt)
.def X_H = R17    ; Dzielna (starszy bajt)
.def Y_L = R18    ; Dzielnik (m³odszy bajt)
.def Y_H = R19    ; Dzielnik (starszy bajt)

.def R_L = R16    ; Reszta (m³odszy bajt)
.def R_H = R17    ; Reszta (starszy bajt)
.def Q_L = R18    ; Iloraz (m³odszy bajt)
.def Q_H = R19    ; Iloraz (starszy bajt)

.def QCtrL = R24  ; Licznik ilorazu (m³odszy)
.def QCtrH = R25  ; Licznik ilorazu (starszy)

; ==========================================
; PÊTLA G£ÓWNA (Test podprogramu)
; ==========================================
MainLoop:
    ; Test z instrukcji: 1200 / 500[cite: 20]
    ldi X_L, low(1200)
    ldi X_H, high(1200)
    
    ldi Y_L, low(500)
    ldi Y_H, high(500)

    rcall Divide

    ; Po powrocie Q_H:Q_L powinno wynosiæ 2, a R_H:R_L powinno wynosiæ 200[cite: 20]
    ; Program zatrzymuje siê w pustej pêtli, aby móc odczytaæ rejestry w symulatorze
KoniecTestu:
    rjmp KoniecTestu

; ==========================================
; PODPROGRAM: Divide 
; ==========================================
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
    

