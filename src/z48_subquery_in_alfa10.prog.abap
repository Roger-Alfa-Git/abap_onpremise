*&---------------------------------------------------------------------*
*& Report Z48_SUBQUERY_IN_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z48_subquery_in_alfa10.

TYPES: BEGIN OF gty_airlines,
         carrname TYPE s_carrname,
       END OF gty_airlines.

DATA: gt_airlines TYPE STANDARD TABLE OF gty_airlines.

SELECT carrname FROM zscarr_alfa10 AS a
  INTO CORRESPONDING FIELDS OF TABLE gt_airlines
  WHERE carrid IN ( SELECT carrid FROM zspfli_alfa10
                           WHERE carrid EQ a~carrid ) .

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_airlines ).
ENDIF.

*//////Ejercicio del video/////////////////////////////////////////////////////////////////
*DATA: gt_spfli TYPE STANDARD TABLE OF zspfli_alfa10.
*
*SELECT * FROM zspfli_alfa10 AS a
*  INTO TABLE gt_spfli
*  WHERE carrid IN ( SELECT carrid FROM zsflight_alfa10
*                           WHERE carrid EQ a~carrid
*                             AND connid EQ a~connid ).
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_spfli ).
*ENDIF.
*
*DATA: gt_flights TYPE STANDARD TABLE OF zsflight_alfa10.
*
*SELECT * FROM zsflight_alfa10
*  INTO TABLE gt_flights.
*
*IF sy-subrc EQ 0 AND gt_flights IS NOT INITIAL.
*
*  SELECT * FROM zspfli_alfa10
*    INTO TABLE gt_spfli
*    FOR ALL ENTRIES IN gt_flights
*    WHERE carrid EQ gt_flights-carrid
*    AND connid EQ gt_flights-connid.
*
*  IF sy-subrc EQ 0.
*    cl_demo_output=>display( gt_spfli ).
*  ENDIF.
*ENDIF.
