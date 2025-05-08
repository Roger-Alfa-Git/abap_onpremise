*&---------------------------------------------------------------------*
*& Report Z12_DELETE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z12_delete_alfa10.

DATA: gt_airlines TYPE STANDARD TABLE OF zscarr_alfa10.

SELECT * FROM zscarr_alfa10
  INTO TABLE gt_airlines
  WHERE carrid IN ( 'QF', 'SA' ).

IF sy-subrc EQ 0.
  DELETE zscarr_alfa10 FROM TABLE gt_airlines.

  IF sy-subrc EQ 0.
    WRITE: / 'Los registros se han eliminado'.
  ENDIF.
ENDIF.
