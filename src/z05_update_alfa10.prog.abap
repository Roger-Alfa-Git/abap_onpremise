*&---------------------------------------------------------------------*
*& Report Z05_UPDATE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z05_update_alfa10.

DATA: gwa_airline TYPE zscarr_alfa10.

SELECT SINGLE * FROM zscarr_alfa10
  INTO gwa_airline
  WHERE carrid = 'AC'.

IF sy-subrc EQ 0.
  WRITE: / 'Moneda anterior', gwa_airline-currcode.
  gwa_airline-currcode = 'USD'.
  UPDATE zscarr_alfa10 FROM gwa_airline.
  IF sy-subrc EQ 0.
    WRITE: / 'Registro actualizado correctamente'.
  ENDIF.
ENDIF.
