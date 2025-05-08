*&---------------------------------------------------------------------*
*& Report Z011_DELETE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z011_delete_alfa10.

*DATA: gwa_airline TYPE zscarr_alfa10.
*
*SELECT SINGLE * FROM zscarr_alfa10
*  INTO gwa_airline
*  WHERE carrid = 'SR'.
*
*IF sy-subrc EQ 0.
*  DELETE zscarr_alfa10 FROM gwa_airline.
*
*  IF sy-subrc EQ 0.
*    WRITE: / 'Registro elminado'.
*  ENDIF.
*ELSE.
*  WRITE: / 'Registro No existe'.
*ENDIF.

DATA: lt_loga TYPE STANDARD TABLE OF zempl_logali,
      lt_alfa TYPE STANDARD TABLE OF zempl_alfa10,
      ls_loga TYPE TABLE OF zempl_logali,
      ls_alfa TYPE TABLE OF zempl_alfa10.

SELECT * FROM zempl_logali
  INTO TABLE lt_loga.

IF sy-subrc EQ 0.

  MOVE-CORRESPONDING lt_loga TO lt_alfa.

  INSERT zempl_alfa10 FROM TABLE lt_alfa .

  IF sy-subrc EQ 0.
    WRITE: 'El N° de registros insertados ',sy-dbcnt.
  ENDIF.
  WRITE: 'El N° de registros insertados ',sy-dbcnt.

ENDIF.
