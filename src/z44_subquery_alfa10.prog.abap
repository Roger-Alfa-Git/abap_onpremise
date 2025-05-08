*&---------------------------------------------------------------------*
*& Report Z44_SUBQUERY_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z44_subquery_alfa10.

DATA: gt_fights TYPE STANDARD TABLE OF zsflight_alfa10.

SELECT * FROM zsflight_alfa10
  INTO TABLE gt_fights
  WHERE planetype EQ ( SELECT planetype FROM zsaplane_alfa10 WHERE planetype EQ '747-400').

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_fights ).
ELSE.
  WRITE: / 'No existe'.
ENDIF.


*////////Ejercicio del video/////////////////////////////////////////////////////////////////////////////////////////////
*DATA: gwa_flight TYPE zsflight_alfa10.
*
*SELECT SINGLE * FROM zsflight_alfa10
*  INTO gwa_flight
*  WHERE seatsocc EQ ( SELECT MAX( seatsocc ) FROM zsflight_alfa10 ).
*
*IF sy-subrc EQ 0.
*  WRITE: / gwa_flight-carrid, gwa_flight-seatsocc.
*ELSE.
*  WRITE: / 'No existe'.
*ENDIF.
*
*
*SELECT SINGLE * FROM zsflight_alfa10
*  INTO gwa_flight
*  WHERE carrid EQ ( SELECT carrid FROM zscarr_alfa10 WHERE carrname EQ 'Singapore Airlines' ).
*
*IF sy-subrc EQ 0.
*  WRITE: / gwa_flight-carrid, gwa_flight-seatsocc.
*ELSE.
*  WRITE: / 'No existe'.
*ENDIF.
*
*
*DATA: gt_fights TYPE STANDARD TABLE OF zsflight_alfa10.
*
*SELECT * FROM zsflight_alfa10
*  INTO TABLE gt_fights
*  WHERE carrid EQ ( SELECT carrid FROM zscarr_alfa10 WHERE carrname EQ 'Lufthansa').
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_fights ).
*ELSE.
*  WRITE: / 'No existe'.
*ENDIF.
