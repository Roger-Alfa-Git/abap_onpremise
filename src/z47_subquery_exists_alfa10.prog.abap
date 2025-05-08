*&---------------------------------------------------------------------*
*& Report Z47_SUBQUERY_EXISTS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z47_subquery_exists_alfa10.

DATA: gt_plane TYPE STANDARD TABLE OF zsaplane_alfa10.

SELECT * FROM zsaplane_alfa10 AS p
  INTO TABLE gt_plane
  WHERE  EXISTS ( SELECT * FROM zsflight_alfa10
                    WHERE planetype EQ p~planetype ).

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_plane ).
ENDIF.

*/////////Ejercicio del video/////////////////////////////////////////////////////////////////
*DATA: gt_flights TYPE STANDARD TABLE OF zsflight_alfa10.
*
*SELECT * FROM zsflight_alfa10 AS a
*  INTO TABLE gt_flights
*  WHERE seatsocc < a~seatsmax AND
*  EXISTS ( SELECT * FROM zspfli_alfa10
*                    WHERE carrid EQ a~carrid AND
*                          connid EQ a~connid AND
*                          cityfrom EQ 'FRANKFURT' ).
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights ).
*ENDIF.
