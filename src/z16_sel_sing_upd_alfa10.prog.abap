*&---------------------------------------------------------------------*
*& Report Z16_SEL_SING_UPD_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z16_sel_sing_upd_alfa10.

DATA: gwa_flight TYPE zspfli_alfa10.

SELECT SINGLE FOR UPDATE *
  FROM zspfli_alfa10 INTO gwa_flight
  WHERE carrid = 'SQ' AND connid = '0002'.

IF sy-subrc EQ 0.
  gwa_flight-fltype = 'X'.
  UPDATE zspfli_alfa10 FROM gwa_flight.
  IF sy-subrc EQ 0.
    WRITE: / 'Registro Actualizado'.
  ENDIF.
ENDIF.


*////////Ejercicio del video////////////////////////////////////////////////////
*DATA: gwa_flight TYPE zspfli_alfa10.
*
*SELECT SINGLE FOR UPDATE *
*  FROM zspfli_alfa10 INTO gwa_flight
*  WHERE carrid = 'AA' AND connid = '0064'.
*
*WRITE sy-subrc.
