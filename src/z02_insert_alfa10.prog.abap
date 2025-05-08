*&---------------------------------------------------------------------*
*& Report Z02_INSERT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z02_insert_alfa10.

DATA: gt_bbdd     TYPE STANDARD TABLE OF zscarr_alfa10,
      gt_airlines TYPE TABLE OF scarr.

SELECT * FROM scarr
  INTO TABLE gt_airlines
  WHERE currcode EQ 'EUR'.

IF sy-subrc EQ 0.

  MOVE-CORRESPONDING gt_airlines TO gt_bbdd.

  INSERT zscarr_alfa10 FROM TABLE gt_bbdd.

  IF sy-subrc EQ 0.
    WRITE: 'El N° de registros insertados ',sy-dbcnt.
  ENDIF.

ENDIF.
