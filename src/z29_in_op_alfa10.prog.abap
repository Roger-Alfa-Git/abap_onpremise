*&---------------------------------------------------------------------*
*& Report Z29_IN_OP_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z29_in_op_alfa10.

DATA: gt_airlines TYPE STANDARD TABLE OF zscarr_alfa10.

select * from zscarr_alfa10
  into table gt_airlines
  where carrid in ( 'QF', 'SA', 'SR' ).

  IF sy-subrc eq 0.
    cl_demo_output=>display( gt_airlines ).
  ENDIF.
