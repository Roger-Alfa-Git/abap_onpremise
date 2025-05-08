*&---------------------------------------------------------------------*
*& Report Z20_SEL_ENDSEL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z20_sel_endsel_alfa10.

DATA: gt_flight  TYPE STANDARD TABLE OF zspfli_alfa10,
      gwa_flight TYPE zspfli_alfa10.
SELECT * FROM zspfli_alfa10 INTO gwa_flight.
  gwa_flight-distid = 'MI'.
  APPEND gwa_flight TO gt_flight.
ENDSELECT.

cl_demo_output=>display( gt_flight ).

*/(/////////////Ejercicios del video//////////////////////////////////////////////////
** Caso 1
*DATA: gt_flight  TYPE STANDARD TABLE OF zspfli_alfa10,
*      gwa_flight TYPE zspfli_alfa10.
*SELECT * FROM zspfli_alfa10 INTO gwa_flight.
**  Aplicar logica
*  ADD 1 TO gwa_flight-distance.
*  APPEND gwa_flight to gt_flight.
*ENDSELECT.
*
*CL_DEMO_OUTPUT=>display( gt_flight ).

** Caso 2
*SELECT * FROM zspfli_alfa10 INTO gwa_flight WHERE carrid = 'AA'.
**  Aplicar logica
*  ADD 1 TO gwa_flight-distance.
*  APPEND gwa_flight TO gt_flight.
*ENDSELECT.
*
*cl_demo_output=>display( gt_flight ).

** Caso 3
*TYPES: BEGIN OF gty_flights,
*         carrid   TYPE  s_carr_id,
*         connid   TYPE  s_conn_id,
*         cityfrom TYPE  s_from_cit,
*       END OF gty_flights.
*DATA: gt_flight_type  TYPE STANDARD TABLE OF gty_flights,
*      gwa_flight_type TYPE gty_flights.
*SELECT * FROM zspfli_alfa10 INTO CORRESPONDING FIELDS OF gwa_flight_type.
**  Aplicar logica
*  APPEND gwa_flight_type TO gt_flight_type.
*ENDSELECT.
*
*cl_demo_output=>display( gt_flight_type ).
