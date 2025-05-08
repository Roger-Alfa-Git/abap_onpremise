*&---------------------------------------------------------------------*
*& Include          Z_EJERCICIOS9_ALFA10_TOP
*&---------------------------------------------------------------------*

TABLES bsik.

DATA: gt_ib            TYPE STANDARD TABLE OF zib_alfa10,
      gwa_ib           TYPE zib_alfa10,
      gwa_inform_banco TYPE zib_alfa10,
      date_from        TYPE sy-datum VALUE '20240428',
      date_to          TYPE sy-datum.
