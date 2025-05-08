*&---------------------------------------------------------------------*
*& Report Z26_BETWEEN_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z26_between_alfa10.

DATA: gt_flights TYPE STANDARD TABLE OF zsflight_alfa10.

SELECT * FROM zsflight_alfa10
  INTO TABLE gt_flights
  WHERE fldate BETWEEN '20220101' AND '20220301'.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flights ).
ENDIF.
