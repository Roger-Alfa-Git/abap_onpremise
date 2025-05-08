*&---------------------------------------------------------------------*
*& Report Z22_SEL_UP_TO_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z22_sel_up_to_alfa10.
DATA: gt_flight TYPE STANDARD TABLE OF zsflight_alfa10.

SELECT * FROM zsflight_alfa10
  INTO TABLE gt_flight
  UP TO 3 ROWS.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flight ).
ENDIF.

*/////////Ejercicio del video//////////////////////////////////////////////
*DATA: gt_airlines TYPE STANDARD TABLE OF zscarr_ALFA10.
*
*SELECT * FROM zscarr_ALFA10
*  INTO TABLE gt_airlines
*  UP TO 3 ROWS.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_airlines ).
*ENDIF.
