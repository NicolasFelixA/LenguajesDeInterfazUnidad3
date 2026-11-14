; ============================================================
; Alumno:   Felix Aguilasocho Nicolas
; Materia:  Lenguajes de Interfaz
; Unidad:   3
; Horario:  10:00 a 11:00
; Tema:     Direcciones de retorno en la pila (CALL y RET)
; ============================================================

INCLUDE Irvine32.inc

.data
	; Este programa no necesita variables

.code
;------------------------------------------------------------
; main: muestra el tope de la pila y llama a procUno
;------------------------------------------------------------
main PROC
	; Al iniciar main, [ESP] contiene la dirección de retorno
	; hacia el sistema que ejecutó el programa
	mov  eax, [esp]
	call WriteHex           ; Imprime EAX en hexadecimal
	call Crlf

	; CALL guarda en la pila la dirección de la instrucción
	; siguiente (exit) y salta a procUno
	call procUno

	exit                    ; Termina el programa
main ENDP

;------------------------------------------------------------
; procUno: muestra su dirección de retorno y llama a procDos
;------------------------------------------------------------
procUno PROC
	; [ESP] tiene la dirección dentro de main a la que
	; regresará RET (la instrucción después de "call procUno")
	mov  eax, [esp]
	call WriteHex
	call Crlf

	; Se apila una nueva dirección de retorno, ahora dentro de procUno
	call procDos

	ret                     ; Regresa a main
procUno ENDP

;------------------------------------------------------------
; procDos: muestra su dirección de retorno
;------------------------------------------------------------
procDos PROC
	; [ESP] tiene la dirección dentro de procUno
	; (la instrucción "ret" que sigue a "call procDos")
	mov  eax, [esp]
	call WriteHex
	call Crlf

	ret                     ; Regresa a procUno
procDos ENDP

END main