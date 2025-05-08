*&---------------------------------------------------------------------*
*& Report Z42_INNER_JOIN_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z42_inner_join_alfa10.

TYPES: BEGIN OF gty_flight,
         carrname  TYPE s_carrname,
         fldate    TYPE s_date,
         price     TYPE s_price,
         planetype TYPE s_planetye,
         producer  TYPE s_prod,
       END OF gty_flight.

DATA gt_flights TYPE TABLE OF gty_flight.

SELECT a~carrname b~fldate b~price b~planetype c~producer
 INTO TABLE gt_flights
 FROM ( zscarr_alfa10 AS a
        INNER JOIN zsflight_alfa10 AS b ON b~carrid EQ a~carrid )
        INNER JOIN zsaplane_alfa10 AS c ON c~planetype EQ b~planetype.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flights ).
ENDIF.

*////////Ejercicio del video/////////////////////////////////////////////////////////////////////////
*PARAMETERS: pa_ctyfr TYPE zspfli_alfa10-cityfrom,
*            pa_ctyto TYPE zspfli_alfa10-cityto.
*
*TYPES: BEGIN OF gty_flight,
*         fldate   TYPE zsflight_alfa10-fldate,
*         carrname TYPE zscarr_alfa10-carrname,
*         connid   TYPE zspfli_alfa10-connid,
*       END OF gty_flight.
*
*DATA: gt_flights TYPE STANDARD TABLE OF gty_flight.
*
*SELECT c~fldate a~carrname b~connid
*  INTO CORRESPONDING FIELDS OF TABLE gt_flights
*  FROM ( zscarr_alfa10 AS a
*         INNER JOIN zspfli_alfa10   AS b ON b~carrid EQ a~carrid )
*         INNER JOIN zsflight_alfa10 AS c ON c~carrid EQ b~carrid
*                                        AND c~connid EQ b~connid.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights ).
*ENDIF.
