*&---------------------------------------------------------------------*
*& Report Z15_SEL_SINGLE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z15_sel_single_alfa10.
TYPES: BEGIN OF gty_flights,
         carrid   TYPE  s_carr_id,
         cityfrom TYPE  s_from_cit,
         airpfrom TYPE  s_fromairp,
         cityto   TYPE  s_to_city,
         airpto   TYPE  s_toairp,
       END OF gty_flights.

DATA: gwa_flight_type TYPE gty_flights.

SELECT SINGLE * FROM zspfli_alfa10
  INTO CORRESPONDING FIELDS OF gwa_flight_type
  WHERE carrid = 'AZ'.

IF sy-subrc EQ 0.
  WRITE: / gwa_flight_type-carrid,
         / gwa_flight_type-cityfrom,
         / gwa_flight_type-airpfrom,
         / gwa_flight_type-cityto,
         / gwa_flight_type-airpto.
ENDIF.

*/////////////Ejercicio del video///////////////////////////////////////////
*DATA: gwa_flight TYPE zspfli_alfa10.
*
*SELECT SINGLE * FROM zspfli_alfa10
*  INTO gwa_flight
*  WHERE carrid = 'AA'.
*
*IF sy-subrc EQ 0.
*  WRITE:/ gwa_flight-cityfrom.
*ENDIF.
*
*TYPES: BEGIN OF gty_flight,
*         carrid    TYPE  s_carr_id,
*         connid    TYPE  s_conn_id,
*         countryfr TYPE  land1,
*         cityfrom  TYPE  s_from_cit,
*       END OF gty_flight.
*
*DATA: gwa_flight_type TYPE gty_flight.
*
*SELECT SINGLE * FROM zspfli_alfa10
*  INTO CORRESPONDING FIELDS OF gwa_flight_type
*  WHERE carrid = 'AA'.
*
*
*IF sy-subrc EQ 0.
*  WRITE:/ gwa_flight_type-cityfrom.
*ENDIF.
