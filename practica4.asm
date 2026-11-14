; ============================================================
; Alumno:   Felix Aguilasocho Nicolas
; Materia:  Lenguajes de Interfaz
; Unidad:   3
; Horario:  10:00 a 11:00
; Tema:     Macros (MACRO / ENDM) con parámetros
; ============================================================

INCLUDE Irvine32.inc

;------------------------------------------------------------
; MostrarMensaje: imprime una cadena y salta de línea
; Parámetro: texto -> nombre de una variable BYTE terminada en 0
;------------------------------------------------------------
MostrarMensaje MACRO texto
	mov  edx, OFFSET texto  ; EDX apunta a la cadena
	call WriteString        ; Imprime la cadena
	call Crlf               ; Salto de línea
ENDM

;------------------------------------------------------------
; Multi: multiplica dos valores e imprime el resultado
; Parámetros: num1, num2 -> valores inmediatos o registros
;------------------------------------------------------------
Multi MACRO num1, num2
	mov  eax, num1          ; EAX = primer valor
	imul eax, num2          ; EAX = EAX * segundo valor
	call WriteInt           ; Imprime EAX como entero con signo
	call Crlf
ENDM

.data
	mensajeBienvenida BYTE "BIENVENIDO AL SISTEMA DE GLOWUP MAKEUP SINALOA", 0
	mensajeFin        BYTE "ADIOS", 0

.code
;------------------------------------------------------------
; main: usa las macros definidas arriba
;------------------------------------------------------------
main PROC
	; Cada llamada a una macro se sustituye por su código
	; en el momento de ensamblar (no hay CALL ni RET)
	MostrarMensaje mensajeBienvenida
	MostrarMensaje mensajeFin

	Multi 4, 5              ; Imprime +20

	exit                    ; Termina el programa
main ENDP

END main