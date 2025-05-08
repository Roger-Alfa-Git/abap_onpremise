*&---------------------------------------------------------------------*
*& Report Z21_SEL_COL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z21_sel_col_alfa10.
TYPES: BEGIN OF gty_flights,
         carrid   TYPE  s_carr_id,
         cityfrom TYPE  s_from_cit,
         airpfrom TYPE  s_fromairp,
         cityto   TYPE  s_to_city,
         airpto   TYPE  s_toairp,
       END OF gty_flights.

DATA: gt_flight       TYPE STANDARD TABLE OF gty_flights,
      gwa_flight_type TYPE gty_flights.

SELECT SINGLE carrid cityfrom airpfrom cityto airpto FROM zspfli_alfa10
  INTO CORRESPONDING FIELDS OF gwa_flight_type.

APPEND gwa_flight_type TO gt_flight.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flight ).
ENDIF.

*/////////Ejercicio del video//////////////////////////////////////////////////////////
** Caso 1
*DATA: gv_cityfrom TYPE s_from_cit.
*
*SELECT SINGLE cityfrom FROM zspfli_alfa10
*  INTO gv_cityfrom
*  WHERE carrid EQ 'AA'.
*
*IF sy-subrc EQ 0.
*  WRITE: / gv_cityfrom.
*ENDIF.
*
*SKIP 3.
*
**   Caso 2
*TYPES: BEGIN OF gty_flights,
*         carrid   TYPE  s_carr_id,
*         connid   TYPE  s_conn_id,
*         cityfrom TYPE  s_from_cit,
*       END OF gty_flights.
*
*DATA: gt_flight       TYPE STANDARD TABLE OF gty_flights,
*      gwa_flight_type TYPE gty_flights.
*
*SELECT SINGLE carrid connid cityfrom FROM zspfli_alfa10
*  INTO gwa_flight_type.
*
*IF sy-subrc EQ 0.
*  WRITE: / gwa_flight_type-carrid,
*         / gwa_flight_type-connid,
*         / gwa_flight_type-cityfrom.
*ENDIF.
*
** Caso 3
*SELECT carrid connid cityfrom FROM zspfli_alfa10
*  INTO TABLE gt_flight.
*
*IF sy-subrc EQ 0.
**  cl_demo_output=>display( gt_flight ).
*ENDIF.
*
*DATA: gt_bbdd TYPE STANDARD TABLE OF zspfli_alfa10.
*
*SELECT carrid connid FROM zspfli_alfa10
*  INTO CORRESPONDING FIELDS OF TABLE gt_bbdd.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_bbdd ).
*ENDIF.
