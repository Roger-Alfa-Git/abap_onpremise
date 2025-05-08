*&---------------------------------------------------------------------*
*& Report Z10_MODIFY_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z10_modify_alfa10.

DATA: gt_airlines TYPE STANDARD TABLE OF zscarr_alfa10.

FIELD-SYMBOLS <gfs_airline> TYPE zscarr_alfa10.

CONSTANTS: gc_http  TYPE c LENGTH 4 VALUE 'http',
           gc_https TYPE c LENGTH 5 VALUE 'https'.

SELECT * FROM zscarr_alfa10
  INTO TABLE gt_airlines.

IF sy-subrc EQ 0.
  LOOP AT gt_airlines ASSIGNING <gfs_airline>.
    REPLACE gc_http WITH gc_https INTO <gfs_airline>-url.
  ENDLOOP.
  <gfs_airline>-carrid = 'IB'.
  <gfs_airline>-carrname = 'Iberia Airlines'.
  <gfs_airline>-currcode = 'EUR'.
  <gfs_airline>-url = 'https://www.iberia.com'.
  APPEND <gfs_airline> TO gt_airlines.

  MODIFY zscarr_alfa10 FROM TABLE gt_airlines.

  IF sy-subrc EQ 0.
    WRITE: / 'Se ha modificado correctamente'.
  ENDIF.
ENDIF.
