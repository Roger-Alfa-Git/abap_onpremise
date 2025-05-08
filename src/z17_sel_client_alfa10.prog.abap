*&---------------------------------------------------------------------*
*& Report Z17_SEL_CLIENT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_sel_client_alfa10.
DATA: gwa_flight TYPE spfli.

SELECT SINGLE * FROM spfli CLIENT SPECIFIED
  INTO gwa_flight
  WHERE mandt EQ '000' AND
        carrid EQ 'LH' AND
        connid EQ 0400.

IF sy-subrc EQ 0.
  WRITE: / gwa_flight-mandt,
         / gwa_flight-cityfrom,
         / gwa_flight-cityto.
ENDIF.

*/////////Ejercicio del video////////////////////////////////////////////////
*DATA: gwa_flight TYPE spfli.
*
*SELECT SINGLE * FROM spfli
*  INTO gwa_flight
*  WHERE carrid EQ 'AA'.
*
*IF sy-subrc EQ 0.
*  WRITE: / gwa_flight-mandt.
*ENDIF.
*
*SELECT SINGLE * FROM spfli CLIENT SPECIFIED
*  INTO gwa_flight
*  WHERE mandt EQ '000' AND
*        carrid EQ 'AA'.
*
*IF sy-subrc EQ 0.
*  WRITE: / gwa_flight-mandt.
*ENDIF.
