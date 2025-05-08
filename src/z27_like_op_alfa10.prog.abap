*&---------------------------------------------------------------------*
*& Report Z27_LIKE_OP_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z27_like_op_alfa10.

PARAMETERS: pa_str TYPE c LENGTH 20.

DATA: gt_text TYPE TABLE OF doktl.

pa_str = '%' && pa_str && '%'.

SELECT * FROM doktl
  INTO TABLE gt_text
  UP TO 5 ROWS
  WHERE doktext LIKE pa_str.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_text ).
ENDIF.
