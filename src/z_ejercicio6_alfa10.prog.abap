*&---------------------------------------------------------------------*
*& Report Z_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EJERCICIO6_ALFA10.

WRITE: 'Indicie de tablas internas = ',sy-tabix,
      / 'Numero del dynpro actual = ', sy-dynnr,
      / '0 Código retorno de sentencias ABAP = ', sy-subrc,
      / 'Día de la semana en calendario fábrica = ', sy-fdayw.



*EjERCICIO ALGO
PARAMETERS pa_msg TYPE c LENGTH 1.

AT SELECTION-SCREEN ON pa_msg.

  IF pa_msg EQ 'E'.

    MESSAGE e012(sabapdocu).

  ELSEIF pa_msg EQ 'W'.

    MESSAGE w013(sabapdocu).

  ENDIF.

START-OF-SELECTION.

CASE pa_msg.
  WHEN 'I'.
*    MESSAGE id 'SABAPDOCU' TYPE 'I' NUMBER 014.
    MESSAGE i014(sabapdocu).

  WHEN 'S'.
    MESSAGE s015(sabapdocu).

  WHEN 'A'.
    MESSAGE a016(sabapdocu).

  WHEN 'X'.
    MESSAGE x012(sabapdocu).

  WHEN OTHERS.
    WRITE / 'El tipo de mensaje no existe'.
ENDCASE.

WRITE / 'Sigue con la logica'.
