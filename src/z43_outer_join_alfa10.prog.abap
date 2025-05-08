*&---------------------------------------------------------------------*
*& Report Z43_OUTER_JOIN_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z43_outer_join_alfa10.

TYPES: BEGIN OF gty_flight,
         planetype TYPE s_planetye,
         carrid    TYPE s_carr_id,
         connid    TYPE s_conn_id,
       END OF gty_flight.

DATA: gt_flights TYPE STANDARD TABLE OF gty_flight.

SELECT a~planetype b~carrid b~connid
  FROM ( zsaplane_alfa10 AS a
  LEFT OUTER JOIN zsflight_alfa10 AS b ON a~planetype EQ b~planetype )
  INTO TABLE gt_flights
  ORDER BY carrid connid DESCENDING.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flights ).
ENDIF.

*//////Ejercicio del video/////////////////////////////////////////////////////////////////
*TYPES: BEGIN OF gty_flight,
*         carrid   TYPE s_carr_id,
*         carrname TYPE s_carrname,
*         fldate   TYPE s_date,
*         price    TYPE s_price,
*         currency TYPE s_currcode,
*       END OF gty_flight.
*
*DATA: gt_flights TYPE STANDARD TABLE OF gty_flight.
*
*SELECT a~carrid a~carrname b~fldate b~price b~currency
*  FROM ( zscarr_alfa10 AS a
*  LEFT OUTER JOIN zsflight_alfa10 AS b ON a~carrid EQ b~carrid )
*  INTO TABLE gt_flights
*  ORDER BY price.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights ).
*ENDIF.
