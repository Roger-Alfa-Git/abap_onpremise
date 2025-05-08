*&---------------------------------------------------------------------*
*& Report Z24_SEL_UP_TO_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z24_sel_up_to_alfa10.
DATA: gt_flight  TYPE TABLE OF zsflight_alfa10,
      gt_flights TYPE TABLE OF zspfli_alfa10.

SELECT * FROM zsflight_alfa10
  INTO TABLE gt_flight
  UP TO 100 ROWS.

IF sy-subrc EQ 0.

  SELECT * FROM zspfli_alfa10
    INTO TABLE gt_flights
    FOR ALL ENTRIES IN gt_flight
    WHERE carrid EQ gt_flight-carrid AND connid EQ gt_flight-connid.

  IF sy-subrc EQ 0.
    cl_demo_output=>display( gt_flights ).
  ENDIF.

ENDIF.


*////////Ejercicio del video//////////////////////////////////////////////////////////
*DATA: gt_airlines TYPE TABLE OF zscarr_alfa10,
*      gt_zspfli   TYPE TABLE OF zspfli_alfa10.
*
*SELECT * FROM zscarr_alfa10
*  INTO TABLE gt_airlines
*  UP TO 5 ROWS.
*
*IF sy-subrc EQ 0.
*
*  SELECT * FROM zspfli_alfa10
*    INTO TABLE gt_zspfli
*    FOR ALL ENTRIES IN gt_airlines
*    WHERE carrid EQ gt_airlines-carrid.
*  IF sy-subrc EQ 0.
*    cl_demo_output=>display( gt_zspfli ).
*  ENDIF.
*ENDIF.
