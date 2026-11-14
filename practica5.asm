; ============================================================
; Alumno:   Felix Aguilasocho Nicolas
; Materia:  Lenguajes de Interfaz
; Unidad:   3
; Horario:  10:00 a 11:00
; Tema:     Validación de cadena vacía con ReadString y CMP/JE
; ============================================================

INCLUDE Irvine32.inc

.data
	cadena     BYTE 50 DUP(0)    ; Buffer para la cadena del usuario
	msgPedir   BYTE "Ingresa una cadena (o presiona Enter para dejarla vacia): ", 0
	msgVacia   BYTE "La cadena ESTA vacia.", 0
	msgNoVacia BYTE "La cadena NO esta vacia.", 0

.code
;------------------------------------------------------------
; main: pide una cadena y avisa si está vacía o no
;------------------------------------------------------------
main PROC
	; 1. Mostrar el mensaje que pide la cadena
	mov  edx, OFFSET msgPedir
	call WriteString

	; 2. Leer la cadena del teclado
	mov  edx, OFFSET cadena       ; EDX = dirección del buffer
	mov  ecx, SIZEOF cadena - 1   ; ECX = máximo de caracteres (deja 1 para el 0 final)
	call ReadString               ; Guarda la cadena; EAX = cantidad de caracteres leídos

	; 3. Validar si está vacía revisando el primer byte
	cmp  BYTE PTR [cadena], 0     ; ¿El primer carácter es el terminador nulo?
	je   EsVacia                  ; Si es 0, no se escribió nada

NoEsVacia:
	mov  edx, OFFSET msgNoVacia
	call WriteString
	call Crlf
	jmp  Fin                      ; Salta para no ejecutar el bloque EsVacia

EsVacia:
	mov  edx, OFFSET msgVacia
	call WriteString
	call Crlf

Fin:
	exit                          ; Termina el programa
main ENDP

END main