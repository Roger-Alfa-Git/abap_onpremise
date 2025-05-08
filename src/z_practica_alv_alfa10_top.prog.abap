*&---------------------------------------------------------------------*
*& Include          Z_PRACTICA_ALV_ALFA10_TOP
*&---------------------------------------------------------------------*

TYPE-POOLS slis.

DATA: gt_flights  TYPE STANDARD TABLE OF sflight,
      gt_fieldcat TYPE TABLE OF slis_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.
