*&---------------------------------------------------------------------*
*& Report Z_EJERCICIOS5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EJERCICIOS5_ALFA10.

*Ejercicio 5.2
data: numero TYPE i.

numero = 7.
WRITE: 'Ejercicio 5.2'.
IF numero EQ 7.

  WRITE: / 'Numero = 7'.

  ELSE.
    WRITE: / 'Numero distinto de 7'.

ENDIF.

numero = 8.

IF numero EQ 7.

  WRITE: / 'Numero = 7'.

  ELSE.
    WRITE: / 'Numero distinto de 7'.

ENDIF.

skip.

*Ejercicio 5.4
data: empresa TYPE string.

empresa = 'LOGALI'.

WRITE: / 'Ejercicio 5.4'.
CASE empresa.
  WHEN 'LOGALI'.
    WRITE: / 'Academica'.
  WHEN 'SAP'.
    WRITE: / 'Software'.
  WHEN OTHERS.
    WRITE: / 'Desconocido'.
ENDCASE.

empresa = 'SAP'.

CASE empresa.
  WHEN 'LOGALI'.
    WRITE: / 'Academica'.
  WHEN 'SAP'.
    WRITE: / 'Software'.
  WHEN OTHERS.
    WRITE: / 'Desconocido'.
ENDCASE.

empresa = 'Roger'.

CASE empresa.
  WHEN 'LOGALI'.
    WRITE: / 'Academica'.
  WHEN 'SAP'.
    WRITE: / 'Software'.
  WHEN OTHERS.
    WRITE: / 'Desconocido'.
ENDCASE.

skip.

*Ejercicio 5.6
data contador TYPE i.

WRITE: / 'Ejercicio 5.6'.
DO 10 TIMES.

WRITE: / 'Numero:',contador.

IF contador eq 7.
EXIT.
ENDIF.

ADD 1 TO contador.

ENDDO.

skip.

*Ejercicio 5.8
contador = 0.

WRITE: / 'Ejercicio 5.8'.

WHILE contador LE 20.

  contador = contador + 1.

  IF contador LE 10.
    WRITE: / 'Numero:', contador.
  ENDIF.

ENDWHILE.

skip.

*Z_VAR_SISTEMA_ALFA10
IF sy-uname EQ 'ALFA03'.
  WRITE: / 'Usuario SAP = ', sy-uname.

ELSE.
  WRITE: / 'Usuario es SAP = ', sy-uname.

ENDIF.

WRITE: / 'Mandante de conexion = ', sy-mandt,
       / 'Idioma de conexion = ', sy-langu,
       / 'Dynpro / Pantalla actual = ', sy-dynnr.

IF sy-batch EQ abap_true.

  WRITE / 'El programa se ejecuta en proceso de fondo'.

ELSE.

  WRITE / 'El programa No se ejecuta en proceso de fondo'.

ENDIF.
