*&---------------------------------------------------------------------*
*& Report Z_EJERCICIOS9_EXT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_EJERCICIOS9_EXT_ALFA10.

DATA: gt_ib TYPE STANDARD TABLE OF zemp_alfa10,
      date_from TYPE sy-datum VALUE '20240428',
      date_to   TYPE sy-datum.

PERFORM execute_task(z_ejercicios9_alfa10) TABLES gt_ib.

PERFORM list_all_records
IN PROGRAM z_ejercicios9_alfa10
USING date_from date_to gt_ib.
