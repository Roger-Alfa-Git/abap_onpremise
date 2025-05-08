*&---------------------------------------------------------------------*
*& Report Z31_NULL_OP_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z31_null_op_alfa10.
DATA: gt_flights TYPE STANDARD TABLE OF zspfli_alfa10.

SELECT * FROM zspfli_alfa10
  INTO TABLE gt_flights
  WHERE fltype IS NOT NULL
  AND fltype NE space.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flights ).
ENDIF.

*////////////Ejercicio del video///////////////////////////////////////////////////////
*DATA: gt_flights TYPE STANDARD TABLE OF zspfli_alfa10.
*
*SELECT * FROM zspfli_alfa10
*  INTO TABLE gt_flights
*  WHERE period IS NOT NULL
*  AND period NE space.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights ).
*ENDIF.
