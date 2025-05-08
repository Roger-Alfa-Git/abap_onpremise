*&---------------------------------------------------------------------*
*& Report Z08_UPDATE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z08_update_alfa10.

UPDATE zsflight_alfa10
SET seatsmax_f = seatsmax_f + 15
    seatsocc_f = seatsocc_f + 18.

IF sy-subrc EQ 0.
  WRITE: / 'Se han actualizado todo los registros'.
ELSE.
  WRITE: / 'NO se han actualizado todo los registros'.
ENDIF.
