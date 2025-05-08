*&---------------------------------------------------------------------*
*& Report Z51_NESTED_CURSOR_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z51_nested_cursor_alfa10.
DATA: gwa_airlines     TYPE zscarr_alfa10,
      gwa_sflight      TYPE zsflight_alfa10,
      gwa_sflight_temp TYPE zsflight_alfa10.

DATA: gv_cursor1 TYPE cursor,
      gv_cursor2 TYPE cursor.

DATA(gr_out) = cl_demo_output=>new( ).

OPEN CURSOR: gv_cursor1 FOR SELECT * FROM zscarr_alfa10
                                 ORDER BY PRIMARY KEY,
             gv_cursor2 FOR SELECT * FROM zsflight_alfa10
                                 ORDER BY PRIMARY KEY.

DO.
  FETCH NEXT CURSOR gv_cursor1 INTO gwa_airlines.
  IF sy-subrc NE 0.
    EXIT.
  ENDIF.
  gr_out->begin_section( |{ gwa_airlines-carrid }| ).

  DO.
    IF NOT gwa_sflight_temp IS INITIAL.
      gwa_sflight = gwa_sflight_temp.
      CLEAR gwa_sflight_temp.
    ELSE.
      FETCH NEXT CURSOR gv_cursor2 INTO gwa_sflight.
      IF sy-subrc NE 0.
        EXIT.
      ELSEIF gwa_sflight-carrid NE gwa_airlines-carrid.
        gwa_sflight_temp = gwa_sflight.
        EXIT.
      ENDIF.
      gr_out->write( |{ gwa_sflight-carrid } { gwa_sflight-connid } { gwa_sflight-fldate } | ).
    ENDIF.
  ENDDO.
  gr_out->end_section( ).
ENDDO.

CLOSE CURSOR: gv_cursor1, gv_cursor2.

gr_out->display( ).


*////////Ejercicio del video/////////////////////////////////////////////////////////////////////
*DATA: gwa_spfli        TYPE zspfli_alfa10,
*      gwa_sflight      TYPE zsflight_alfa10,
*      gwa_sflight_temp TYPE zsflight_alfa10.
*
*DATA: gv_cursor1 TYPE cursor,
*      gv_cursor2 TYPE cursor.
*
*DATA(gr_out) = cl_demo_output=>new( ).
*
*OPEN CURSOR: gv_cursor1 FOR SELECT * FROM zspfli_alfa10
*                                 ORDER BY PRIMARY KEY,
*             gv_cursor2 FOR SELECT * FROM zsflight_alfa10
*                                 ORDER BY PRIMARY KEY.
*
*DO.
*  FETCH NEXT CURSOR gv_cursor1 INTO gwa_spfli.
*  IF sy-subrc NE 0.
*    EXIT.
*  ENDIF.
*  gr_out->begin_section( |{ gwa_spfli-carrid } { gwa_spfli-connid }| ).
*
*  DO.
*    IF NOT gwa_sflight_temp IS INITIAL.
*      gwa_sflight = gwa_sflight_temp.
*      CLEAR gwa_sflight_temp.
*    ELSE.
*      FETCH NEXT CURSOR gv_cursor2 INTO gwa_sflight.
*      IF sy-subrc NE 0.
*        EXIT.
*      ELSEIF gwa_sflight-carrid NE gwa_spfli-carrid
*          OR gwa_sflight-connid NE gwa_spfli-connid.
*        gwa_sflight_temp = gwa_sflight.
*        EXIT.
*      ENDIF.
*      gr_out->write( |{ gwa_sflight-carrid } { gwa_sflight-connid } { gwa_sflight-fldate } | ).
*    ENDIF.
*  ENDDO.
*  gr_out->end_section( ).
*
*ENDDO.
*
*CLOSE CURSOR: gv_cursor1, gv_cursor2.
*
*gr_out->display( ).
