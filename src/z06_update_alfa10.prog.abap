*&---------------------------------------------------------------------*
*& Report Z06_UPDATE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z06_update_alfa10.

DATA: gt_airline  TYPE STANDARD TABLE OF zscarr_alfa10,
      gwa_airline TYPE zscarr_alfa10.

CONSTANTS: gc_home TYPE c LENGTH 5 VALUE '/home'.

SELECT * FROM zscarr_alfa10
  INTO TABLE gt_airline.

IF sy-subrc EQ 0.

  LOOP AT gt_airline INTO gwa_airline.
    CONCATENATE gwa_airline-url gc_home INTO gwa_airline-url.
    UPDATE zscarr_alfa10 FROM gwa_airline.
  ENDLOOP.

  IF sy-subrc EQ 0.
    WRITE: / 'Se han actualizado todos los registros'.
  ELSE.
    WRITE: / 'No se han actualizado todos los registros'.
  ENDIF.

ENDIF.
