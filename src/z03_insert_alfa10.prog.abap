*&---------------------------------------------------------------------*
*& Report Z03_INSERT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z03_insert_alfa10.

DATA: gt_bbdd     TYPE STANDARD TABLE OF zscarr_alfa10,
      gt_airlines TYPE TABLE OF scarr,
      gcx_root    TYPE REF TO cx_root.

SELECT * FROM scarr
  INTO TABLE gt_airlines
  WHERE currcode NE 'USD'.

IF sy-subrc EQ 0.

  MOVE-CORRESPONDING gt_airlines TO gt_bbdd.
  TRY.
      INSERT zscarr_alfa10 FROM TABLE gt_bbdd.
    CATCH cx_sy_open_sql_db INTO gcx_root .
      WRITE: / gcx_root->get_text( ).
  ENDTRY.

  IF sy-subrc EQ 0.
    WRITE: 'El N° de registros insertados ',sy-dbcnt.
  ENDIF.

ENDIF.
