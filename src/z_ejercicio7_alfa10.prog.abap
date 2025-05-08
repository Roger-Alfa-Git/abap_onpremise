*&---------------------------------------------------------------------*
*& Report Z_EJERCICIO7_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EJERCICIO7_ALFA10.

PARAMETERS pa_msg TYPE c LENGTH 1.

AT SELECTION-SCREEN ON pa_msg.


*Ejercicio 7.8
CASE pa_msg.
  WHEN 'I'.
    MESSAGE i014(sabapdocu).
  WHEN 'S'.
    MESSAGE s015(sabapdocu).
  WHEN 'A'.
    MESSAGE a016(sabapdocu).
  WHEN OTHERS.
    WRITE 'No existe ese parametros'.
ENDCASE.

SKIP.

data: total TYPE i,
      numero TYPE i,
      cadena TYPE string.

numero = 4.

cadena = '8'.

total = numero + cadena.

WRITE total.
