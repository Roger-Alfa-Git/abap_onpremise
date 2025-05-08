*&---------------------------------------------------------------------*
*& Report Z28_ESCAPE_OP_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z28_escape_op_alfa10.

DATA: gt_tax_name TYPE STANDARD TABLE OF ztax_code,
      gv_str      TYPE c LENGTH 20.

gv_str = '%' && '27#%' && '%'.

SELECT * FROM ztax_code
  INTO TABLE gt_tax_name
  WHERE text1 LIKE gv_str ESCAPE '#'.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_tax_name ).
ENDIF.
