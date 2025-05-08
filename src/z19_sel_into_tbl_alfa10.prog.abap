*&---------------------------------------------------------------------*
*& Report Z19_SEL_INTO_TBL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z19_sel_into_tbl_alfa10.
DATA: gt_flight TYPE STANDARD TABLE OF zspfli_alfa10.

SELECT * FROM zspfli_alfa10
  INTO TABLE gt_flight.

APPEND INITIAL LINE TO gt_flight.

SELECT * FROM zspfli_alfa10
  APPENDING TABLE gt_flight.

cl_demo_output=>display( gt_flight ).
*/////////Codigo del video//////////////////////////////////////////////
** Caso 1
*DATA: gt_flight TYPE STANDARD TABLE OF zspfli_alfa10.
*
*SELECT * FROM zspfli_alfa10
*  INTO TABLE gt_flight.
*
*APPEND INITIAL LINE TO gt_flight.
*
*SELECT * FROM zspfli_alfa10
*  APPENDING TABLE gt_flight.
*
*cl_demo_output=>display( gt_flight ).
*
**  Caso 2
*
*TYPES: BEGIN OF gty_flight,
*         carrid   TYPE  s_carr_id,
*         connid   TYPE  s_conn_id,
*         cityfrom TYPE s_from_cit,
*       END OF gty_flight.
*
*DATA: gt_flight_type TYPE STANDARD TABLE OF gty_flight.
*
*
*SELECT * FROM zspfli_alfa10
*  INTO CORRESPONDING FIELDS OF TABLE gt_flight_type.
*
*APPEND INITIAL LINE TO gt_flight_type.
*
*SELECT * FROM zspfli_alfa10
*  APPENDING CORRESPONDING FIELDS OF TABLE gt_flight_type.
*
*cl_demo_output=>display( gt_flight_type ).
