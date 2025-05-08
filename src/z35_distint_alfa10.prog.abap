*&---------------------------------------------------------------------*
*& Report Z35_DISTINT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z35_distint_alfa10.

DATA: gv_capacity_seats TYPE s_smax_b,
      gv_occupied_seats TYPE s_socc_b.

SELECT AVG( DISTINCT seatsmax_b )
SUM( DISTINCT seatsocc_b )
FROM zsflight_alfa10
INTO ( gv_capacity_seats, gv_occupied_seats ).

IF sy-subrc EQ 0.
  WRITE: / gv_capacity_seats,
  / gv_occupied_seats.
ENDIF.
