*&---------------------------------------------------------------------*
*& Report Z49_OPEN_CLOSE_CURSOR_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z49_open_close_cursor_alfa10.

DATA: gwa_plane   TYPE zsaplane_alfa10,
      gv_cursor   TYPE cursor,
      gv_finished TYPE abap_bool.

OPEN CURSOR gv_cursor FOR SELECT * FROM zsaplane_alfa10 WHERE producer EQ 'BOE'.

WHILE gv_finished EQ abap_false.
  FETCH NEXT CURSOR gv_cursor INTO gwa_plane.

  IF sy-subrc EQ 0.
    WRITE: / gwa_plane-planetype, gwa_plane-producer.
  ELSE.
    CLOSE CURSOR gv_cursor.
    gv_finished = abap_true.
  ENDIF.
ENDWHILE.



*//////Ejercicio del video///////////////////////////////////////////////////////////////////////////////////////////
*DATA: gwa_spfli   TYPE zspfli_alfa10,
*      gv_cursor   TYPE cursor,
*      gv_finished TYPE abap_bool.
*
*OPEN CURSOR gv_cursor FOR SELECT * FROM zspfli_alfa10 where carrid eq 'LH' ORDER BY CARRID.
*
*WHILE gv_finished EQ abap_false.
*  FETCH NEXT CURSOR gv_cursor INTO gwa_spfli.
*
*  IF sy-subrc EQ 0.
*    WRITE: / gwa_spfli-carrid, gwa_spfli-connid.
*  ELSE.
*    CLOSE CURSOR gv_cursor.
*    gv_finished = abap_true.
*  ENDIF.
*ENDWHILE.
