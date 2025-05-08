*&---------------------------------------------------------------------*
*& Include          Z_ALV_MF_ALFA10_TOP
*&---------------------------------------------------------------------*

TYPE-POOLS slis.

TYPES: BEGIN OF gty_flights,
         carrid   TYPE s_carr_id,
         connid   TYPE s_conn_id,
         price    TYPE s_price,
         currency TYPE s_currcode,
         seatsmax TYPE s_seatsmax,
         seatsocc TYPE s_seatsocc,
       END OF gty_flights.

DATA: gt_flights  TYPE STANDARD TABLE OF gty_flights,
      gt_fieldcat TYPE TABLE OF  slis_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv,
      gt_events   TYPE  slis_t_event.

DATA: gt_header TYPE TABLE OF spfli,
      gt_items  TYPE TABLE OF sflight.
