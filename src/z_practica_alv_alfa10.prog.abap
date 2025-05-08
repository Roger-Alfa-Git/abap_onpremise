*&---------------------------------------------------------------------*
*& Report Z_PRACTICA_ALV_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_practica_alv_alfa10.

INCLUDE z_practica_alv_alfa10_top.
INCLUDE z_practica_alv_alfa10_sel.
INCLUDE z_practica_alv_alfa10_f01.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM build_field_cat.
  PERFORM build_layout.
  PERFORM display_alv_list.
