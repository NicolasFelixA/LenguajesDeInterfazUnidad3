; ============================================================
; Alumno:   Felix Aguilasocho Nicolas
; Materia:  Lenguajes de Interfaz
; Unidad:   3
; Horario:  10:00 a 11:00
; Tema:     Procedimientos con CALL y RET
; ============================================================

INCLUDE Irvine32.inc

.data
	mensajeInicio        BYTE "Inicio de programa", 0
	mensajeProcedimiento BYTE "Estoy dentro del procedimiento", 0
	mensajeFin           BYTE "Fin del programa", 0

.code
;------------------------------------------------------------
; main: procedimiento principal, punto de entrada del programa
;------------------------------------------------------------
main PROC
	; Muestra el mensaje de inicio en pantalla
	mov  edx, OFFSET mensajeInicio
	call WriteString
	call Crlf

	; Primera llamada al procedimiento
	; CALL guarda en la pila la dirección de la siguiente instrucción
	; y luego EIP salta al inicio de mensajeAviso
	call mensajeAviso

	mov  eax, 10            ; Se ejecuta al regresar de la primera llamada

	; Segunda llamada al mismo procedimiento
	; Demuestra que un procedimiento se puede reutilizar
	call mensajeAviso

	mov  eax, 20            ; Se ejecuta al regresar de la segunda llamada

	; Muestra el mensaje de fin en pantalla
	mov  edx, OFFSET mensajeFin
	call WriteString
	call Crlf

	exit                    ; Termina el programa
main ENDP

;------------------------------------------------------------
; mensajeAviso: imprime un mensaje desde dentro de un procedimiento
;------------------------------------------------------------
mensajeAviso PROC
	mov  edx, OFFSET mensajeProcedimiento
	call WriteString
	call Crlf
	ret                     ; Saca de la pila la dirección guardada por CALL
	                        ; y EIP regresa a la instrucción siguiente al CALL
mensajeAviso ENDP

END main