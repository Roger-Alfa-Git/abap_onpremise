*&---------------------------------------------------------------------*
*& Report Z38_HAVING_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z38_having_alfa10.

TYPES: BEGIN OF gty_flight,
         carrid   TYPE s_carr_id,
         cityfrom TYPE s_from_cit,
         count    TYPE i,
       END OF gty_flight.

DATA: gt_flights TYPE STANDARD TABLE OF gty_flight.

SELECT carrid cityfrom COUNT( DISTINCT connid )
  FROM zspfli_alfa10
  INTO TABLE gt_flights
  GROUP BY carrid cityfrom HAVING cityfrom EQ 'FRANKFURT' ORDER BY carrid ASCENDING.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flights ).
ENDIF.

*/////////Ejercicio del video/////////////////////////////////////////////////////////////////////////////////////

*DATA: BEGIN OF gwa_flight,
*        carrid   TYPE  s_carr_id,
*        currency TYPE  s_currcode,
*        min      TYPE p DECIMALS 2,
*        max      TYPE p DECIMALS 2,
*      END OF gwa_flight.
*SELECT carrid currency MIN( price ) MAX( price )
*  FROM zsflight_alfa10
*  INTO (gwa_flight-carrid, gwa_flight-currency, gwa_flight-min, gwa_flight-max )
*  WHERE fldate BETWEEN '20220101' AND '20220301'
*  GROUP BY carrid currency HAVING currency EQ 'USD'.
*
*  WRITE: / gwa_flight-carrid, gwa_flight-currency, gwa_flight-min, gwa_flight-max.
*ENDSELECT.



*TYPES: BEGIN OF gty_flight,
*         carrid   TYPE  s_carr_id,
*         currency TYPE  s_currcode,
*         min      TYPE p DECIMALS 2,
*         max      TYPE p DECIMALS 2,
*       END OF gty_flight.
*
*DATA: gt_flights TYPE STANDARD TABLE OF gty_flight.
*
*SELECT carrid currency MIN( price ) MAX( price )
*  FROM zsflight_alfa10
*  INTO TABLE gt_flights
*  WHERE fldate BETWEEN '20220101' AND '20220301'
*  GROUP BY carrid currency HAVING currency EQ 'EUR'.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights ).
*ENDIF.
