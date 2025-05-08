*&---------------------------------------------------------------------*
*& Report Z41_ALIAS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z41_alias_alfa10.

TYPES: BEGIN OF gty_fly,
         ciudad_salida  TYPE s_from_cit,
         ciudad_llegada TYPE s_to_city,
       END OF gty_fly.

DATA: gt_fly TYPE STANDARD TABLE OF gty_fly.

SELECT cityfrom AS ciudad_salida
  cityto AS ciudad_llegada
  FROM zspfli_alfa10
  into table gt_fly.

  IF sy-subrc EQ 0.
    cl_demo_output=>display( gt_fly  ).
  ENDIF.

*////////Ejercicio del video////////////////////////////////////////////////////////////
*TYPES: BEGIN OF gty_flight,
*         comp_aerea TYPE s_carr_id,
*         moneda     TYPE s_currcode,
*       END OF gty_flight.
*
*DATA: gt_flights TYPE STANDARD TABLE OF  gty_flight .
*
*SELECT carrid AS comp_aerea
*       currency AS moneda
*  FROM zsflight_alfa10 AS vuelos
*  INTO TABLE gt_flights
*  WHERE carrid NE space
*  GROUP BY carrid currency
*  ORDER BY comp_aerea moneda.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights  ).
*ENDIF.
