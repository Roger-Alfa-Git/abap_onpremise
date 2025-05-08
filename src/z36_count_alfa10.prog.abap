*&---------------------------------------------------------------------*
*& Report Z36_COUNT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z36_count_alfa10.

DATA: gv_count TYPE i.

SELECT COUNT( * ) FROM zspfli_alfa10
  INTO gv_count
  WHERE carrid = 'JL'.

IF sy-subrc EQ 0.
  WRITE: / gv_count.
ENDIF.

*///////Ejercicio del video/////////////////////////////////////////////////////////////
*DATA: gv_count TYPE i.
*
*SELECT COUNT( * ) FROM zspfli_alfa10
*  INTO gv_count.
*
*IF sy-subrc EQ 0.
*  WRITE: / gv_count.
*ENDIF.
*
*SELECT COUNT( * ) FROM zspfli_alfa10
*  INTO gv_count
*  WHERE carrid = 'LH'.
*
*IF sy-subrc EQ 0.
*  WRITE: / gv_count.
*ENDIF.
*
*SELECT COUNT( DISTINCT period ) FROM zspfli_alfa10
*  INTO gv_count
*  WHERE carrid = 'LH'.
*
*IF sy-subrc EQ 0.
*  WRITE: / gv_count.
*ENDIF.
