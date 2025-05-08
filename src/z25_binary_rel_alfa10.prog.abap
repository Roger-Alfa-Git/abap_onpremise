*&---------------------------------------------------------------------*
*& Report Z25_BINARY_REL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z25_binary_rel_alfa10.

DATA: gt_flights TYPE STANDARD TABLE OF zsflight_alfa10.

SELECT * FROM zsflight_alfa10
  INTO TABLE gt_flights
  WHERE fldate GE '20220101' AND fldate LE '20220301'.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flights ).
ENDIF.


*///////////Ejercicio del video///////////////////////////////////////////////////////
*SELECT * FROM zsflight_alfa10
*  INTO TABLE gt_flights
*  WHERE fldate GE '20220114'.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights ).
*ENDIF.
