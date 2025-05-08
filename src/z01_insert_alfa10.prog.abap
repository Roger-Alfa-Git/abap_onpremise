*&---------------------------------------------------------------------*
*& Report ZBD_T2_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_insert_alfa10.

DATA: gwa_aviones TYPE zscarr_alfa10.

gwa_aviones-carrid = 'BA'.
gwa_aviones-carrname = 'British Airways'.
gwa_aviones-currcode = 'GBP'.
gwa_aviones-url = 'http://www.british-airways.com/'.

INSERT zscarr_alfa10 FROM gwa_aviones.

IF sy-subrc EQ 0.
  MESSAGE 'Registro insertado' TYPE 'I'.
ENDIF.
