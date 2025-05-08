*&---------------------------------------------------------------------*
*& Report Z_INSERT_WA_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_insert_wa_alfa10.

DATA: gwa_airline TYPE zscarr_alfa10.

gwa_airline-mandt = '810'.
gwa_airline-carrid = 'AA'.
gwa_airline-carrname = 'American Airlines'.
gwa_airline-currcode = 'USD'.
gwa_airline-url = 'HTTP://WWW.AMERICANAIRLINES,COM'.

*INSERT INTO zscarr_alfa10 VALUES gwa_airline.
*INSERT zscarr_alfa10 FROM gwa_airline.
INSERT zscarr_alfa10 CLIENT SPECIFIED FROM gwa_airline.

IF sy-subrc EQ 0.
  MESSAGE 'Registro insertado correctamente' TYPE 'I'.
ELSE.
  MESSAGE 'Registro no se inserto' TYPE 'I'.
ENDIF.
