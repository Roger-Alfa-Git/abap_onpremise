*&---------------------------------------------------------------------*
*& Report Z09_MODIFY_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z09_modify_alfa10.

DATA: gwa_airline TYPE zscarr_alfa10.

SELECT SINGLE * FROM zscarr_alfa10
  INTO gwa_airline
  WHERE carrid = 'CO'.

IF sy-subrc EQ 0.
  gwa_airline-carrid = 'WZ'.

  MODIFY zscarr_alfa10 FROM gwa_airline.

  IF sy-subrc EQ 0.
    WRITE: / 'El registro se inserto correctamente'.
  ELSE.
    WRITE: / 'El registro No se inserto correctamente'.
  ENDIF.
ENDIF.
