*&---------------------------------------------------------------------*
*& Report Z50_PARALEL_CURSOR_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z50_paralel_cursor_alfa10.

DATA: gv_cursor1 TYPE cursor,
      gv_cursor2 TYPE cursor,
      gwa_plane1 TYPE zsaplane_alfa10,
      gwa_plane2 TYPE zsaplane_alfa10,
      gv_flag1   TYPE abap_bool,
      gv_flag2   TYPE abap_bool.

OPEN CURSOR: gv_cursor1 FOR SELECT planetype producer
                              FROM zsaplane_alfa10
                              WHERE producer EQ 'BA',
             gv_cursor2 FOR SELECT planetype producer
                              FROM zsaplane_alfa10
                              WHERE producer EQ 'BOE'.

DO.
  IF gv_flag1 EQ abap_false.
    FETCH NEXT CURSOR gv_cursor1 INTO CORRESPONDING FIELDS OF gwa_plane1.
    IF sy-subrc EQ 0.
      WRITE: / gwa_plane1-planetype, gwa_plane1-producer.
    ELSE.
      CLOSE CURSOR gv_cursor1.
      gv_flag1 = abap_true.
    ENDIF.
  ENDIF.
  IF gv_flag2 EQ abap_false.
    FETCH NEXT CURSOR gv_cursor2 INTO CORRESPONDING FIELDS OF gwa_plane2.
    IF sy-subrc EQ 0.
      WRITE: / gwa_plane2-planetype, gwa_plane2-producer.
    ELSE.
      CLOSE CURSOR gv_cursor2.
      gv_flag2 = abap_true.
    ENDIF.
  ENDIF.
  IF gv_flag1 EQ abap_true AND gv_flag2 EQ abap_true.
    EXIT.
  ENDIF.
ENDDO.

*/////////Ejercicio del video/////////////////////////////////////////////////////////////////////
*DATA: gv_cursor1 TYPE cursor,
*      gv_cursor2 TYPE cursor,
*      gwa_spfli1 TYPE zspfli_alfa10,
*      gwa_spfli2 TYPE zspfli_alfa10,
*      gv_flag1   TYPE abap_bool,
*      gv_flag2   TYPE abap_bool.
*
*OPEN CURSOR: gv_cursor1 FOR SELECT carrid connid
*                              FROM zspfli_alfa10
*                              WHERE carrid EQ 'LH',
*             gv_cursor2 FOR SELECT carrid connid
*                              FROM zspfli_alfa10
*                              WHERE carrid EQ 'SQ'.
*
*DO.
*  IF gv_flag1 EQ abap_false.
*    FETCH NEXT CURSOR gv_cursor1 INTO CORRESPONDING FIELDS OF gwa_spfli1.
*    IF sy-subrc EQ 0.
*      WRITE: / gwa_spfli1-carrid, gwa_spfli1-connid.
*    ELSE.
*      CLOSE CURSOR gv_cursor1.
*      gv_flag1 = abap_true.
*    ENDIF.
*  ENDIF.
*  IF gv_flag2 EQ abap_false.
*    FETCH NEXT CURSOR gv_cursor2 INTO CORRESPONDING FIELDS OF gwa_spfli2.
*    IF sy-subrc EQ 0.
*      WRITE: / gwa_spfli2-carrid, gwa_spfli2-connid.
*    ELSE.
*      CLOSE CURSOR gv_cursor2.
*      gv_flag2 = abap_true.
*    ENDIF.
*  ENDIF.
*  IF gv_flag1 EQ abap_true AND gv_flag2 EQ abap_true.
*    EXIT.
*  ENDIF.
*ENDDO.
