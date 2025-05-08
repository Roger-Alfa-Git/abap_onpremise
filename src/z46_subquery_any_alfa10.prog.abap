*&---------------------------------------------------------------------*
*& Report Z46_SUBQUERY_ANY_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z46_subquery_any_alfa10.

DATA: gt_airlines TYPE STANDARD TABLE OF zscarr_alfa10.

SELECT * FROM zscarr_alfa10
  INTO TABLE gt_airlines
  WHERE carrid EQ SOME ( SELECT carrid FROM zspfli_alfa10 WHERE cityfrom EQ 'FRANKFURT' ).

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_airlines ).
ENDIF.


*///////Ejercicio del video///////////////////////////////////////////////////////////////////////////
*DATA: gt_airlines TYPE STANDARD TABLE OF zscarr_alfa10.
*
*SELECT * FROM zscarr_alfa10
*  INTO TABLE gt_airlines
*  WHERE carrid EQ ANY ( SELECT carrid FROM zsflight_alfa10 WHERE seatsmax GE 350 ).
*
*IF sy-subrc EQ 0.
*
*  IF gt_airlines IS INITIAL.
*    WRITE: / 'La tabla de aerolíneas está vacía.'.
*  ELSE.
*    cl_demo_output=>display( gt_airlines ).
*  ENDIF.
*ENDIF.
