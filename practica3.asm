; ============================================================
; Alumno:   Felix Aguilasocho Nicolas
; Materia:  Lenguajes de Interfaz
; Unidad:   3
; Horario:  10:00 a 11:00
; Tema:     Paso de parámetros por la pila y marco de pila (EBP)
; ============================================================

INCLUDE Irvine32.inc

.data
	; Este programa no necesita variables

.code
;------------------------------------------------------------
; main: apila los parámetros y llama al procedimiento
;------------------------------------------------------------
main PROC
	mov  ebx, 10            ; Valor de prueba: sirve para comprobar que
	                        ; el procedimiento restaura EBX al terminar

	; Los parámetros se apilan antes del CALL
	push 1                  ; Primer parámetro
	push 2                  ; Segundo parámetro

	call sumarPila          ; Apila la dirección de retorno y salta

	nop                     ; Aquí se puede poner un breakpoint para ver EAX
	exit                    ; Termina el programa
main ENDP

;------------------------------------------------------------
; sumarPila: toma dos parámetros de la pila y los multiplica
; Resultado: EAX
;------------------------------------------------------------
sumarPila PROC
	push ebp                ; Guarda el EBP anterior en la pila
	mov  ebp, esp           ; EBP queda fijo como punto de referencia,
	                        ; aunque ESP cambie después con más push/pop

	push ebx                ; Guarda EBX para devolverlo intacto al final

	; Mapa de la pila a partir de EBP:
	;   [ebp+12] -> 1  (primer parámetro)
	;   [ebp+8]  -> 2  (segundo parámetro)
	;   [ebp+4]  -> dirección de retorno
	;   [ebp]    -> EBP anterior
	mov  eax, [ebp+8]       ; EAX = 2
	mov  ebx, [ebp+12]      ; EBX = 1

	imul eax, ebx           ; EAX = EAX * EBX
	                        ; (imul acepta dos registros; mul siempre usa EAX)

	pop  ebx                ; Restaura EBX (vuelve a valer 10)
	pop  ebp                ; Restaura el EBP de quien llamó

	ret  8                  ; Regresa a main y suma 8 a ESP para eliminar
	                        ; los 2 parámetros (2 x 4 bytes) de la pila
sumarPila ENDP

END main