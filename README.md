# Lenguajes de Interfaz – Unidad 3

Repositorio con las cinco prácticas de la **Unidad 3** de la materia **Lenguajes de Interfaz**, desarrolladas en **ensamblador x86 (MASM)** con la librería **Irvine32** en Visual Studio.

| Dato | Información |
|------|-------------|
| **Alumno** | Felix Aguilasocho Nicolas |
| **Materia** | Lenguajes de Interfaz |
| **Unidad** | 3 |
| **Horario** | 10:00 a 11:00 |

---

## Contenido del repositorio

````
.
├── practica1.asm   # Procedimientos con CALL y RET
├── practica2.asm   # Direcciones de retorno en la pila
├── practica3.asm   # Paso de parámetros por la pila (marco de pila con EBP)
├── practica4.asm   # Macros con parámetros
├── practica5.asm   # Validación de cadena vacía
└── README.md
````

Todo el código fuente incluye encabezado con los datos del alumno y comentarios que explican cada bloque de instrucciones.

---

## Requisitos

- Visual Studio con soporte para C++ y MASM activado (*Build Dependencies → Build Customizations → masm*).
- Librería **Irvine32** (`Irvine32.inc`, `Irvine32.lib`, `Macros.inc`).
- Plataforma de compilación **x86 (Win32)**. Irvine32 no funciona en x64.
- Linker: `irvine32.lib;kernel32.lib;user32.lib`, subsistema `Console` y `/SAFESEH:NO`.

---

## Prácticas

### Práctica 1 – Procedimientos con CALL y RET

**Archivo:** `practica1.asm`

**Qué hace:** Imprime un mensaje de inicio, llama dos veces a un procedimiento (`mensajeAviso`) que imprime un mensaje desde dentro de él, y al final imprime un mensaje de cierre.

**Concepto clave:** `CALL` guarda en la pila la dirección de la siguiente instrucción y `EIP` salta al procedimiento. `RET` recupera esa dirección y regresa. Un mismo procedimiento se puede reutilizar varias veces.

**Salida esperada:**
````
Inicio de programa
Estoy dentro del procedimiento
Estoy dentro del procedimiento
Fin del programa
````

**Qué comprobé:** Que el mensaje del procedimiento aparece dos veces, una por cada `CALL`, y que después de cada llamada la ejecución continúa en la instrucción siguiente.

---

### Práctica 2 – Direcciones de retorno en la pila

**Archivo:** `practica2.asm`

**Qué hace:** Tres procedimientos anidados (`main` → `procUno` → `procDos`). Al entrar a cada uno se lee `[ESP]` y se imprime en hexadecimal con `WriteHex`.

**Concepto clave:** Cada `CALL` apila una dirección de retorno distinta y cada `RET` la saca, lo que permite anidar procedimientos sin perder el camino de regreso.

**Salida esperada:** Tres valores hexadecimales de 8 dígitos (cambian en cada ejecución):
1. Dirección de retorno al sistema.
2. Dirección dentro de `main`, justo después de `call procUno`.
3. Dirección dentro de `procUno`, justo después de `call procDos`.

**Qué comprobé:** Que se imprimen tres direcciones distintas y que la tercera es ligeramente mayor que la segunda, porque `procUno` está más adelante en memoria que `main`.

---

### Práctica 3 – Paso de parámetros por la pila

**Archivo:** `practica3.asm`

**Qué hace:** `main` apila dos parámetros (`1` y `2`) y llama a `sumarPila`, que los lee usando `EBP` como punto de referencia y los multiplica con `IMUL`. El resultado queda en `EAX`.

**Concepto clave:** Marco de pila (*stack frame*): `push ebp` / `mov ebp, esp` para fijar una referencia, acceso a parámetros con `[ebp+8]` y `[ebp+12]`, y limpieza de la pila con `ret 8`.

> Nota: aunque el procedimiento se llama `sumarPila`, la operación que realiza es una **multiplicación** (`imul`).

**Resultado esperado:** `EAX = 2` (2 × 1) y `EBX = 10`, intacto.

**Qué comprobé:** Con el depurador y la ventana de Registros, que al llegar al `nop` `EAX` vale 2 y que `EBX` conserva su valor original (10), lo que confirma que el procedimiento guarda y restaura el registro.

---

### Práctica 4 – Macros con parámetros

**Archivo:** `practica4.asm`

**Qué hace:** Define dos macros: `MostrarMensaje` (imprime una cadena y salta de línea) y `Multi` (multiplica dos valores e imprime el resultado). Se usan en `main` para mostrar un mensaje de bienvenida, uno de despedida y el resultado de 4 × 5.

**Concepto clave:** Una macro se **copia** en cada lugar donde se usa, en tiempo de ensamblado. No usa `CALL` ni `RET`, a diferencia de un procedimiento que existe una sola vez en memoria.

**Salida esperada:**
````
BIENVENIDO AL SISTEMA DE GLOWUP MAKEUP SINALOA
ADIOS
+20
````

**Qué comprobé:** Que las macros se expanden correctamente con distintos parámetros y que `WriteInt` muestra el resultado con signo (`+20`).

---

### Práctica 5 – Validación de cadena vacía

**Archivo:** `practica5.asm`

**Qué hace:** Pide una cadena al usuario con `ReadString` y revisa el primer byte del buffer con `CMP` y `JE` para indicar si la cadena está vacía o no.

**Concepto clave:** Saltos condicionales y manejo de cadenas terminadas en nulo. Se reserva un byte para el terminador (`SIZEOF cadena - 1`) para evitar desbordar el buffer.

**Salida esperada:**

| Entrada | Salida |
|---------|--------|
| `hola` + Enter | `La cadena NO esta vacia.` |
| Solo Enter | `La cadena ESTA vacia.` |

**Qué comprobé:** Ambos casos: con texto escrito y presionando solo Enter.

---
