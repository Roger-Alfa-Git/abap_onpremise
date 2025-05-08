*&---------------------------------------------------------------------*
*& Report Z_PRACTICA_ALV_2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_practica_alv_2_alfa10.

INCLUDE z_practica_alv_2_alfa10_top.
INCLUDE z_practica_alv_2_alfa10_sel.
INCLUDE z_practica_alv_2_alfa10_f01.

START-OF-SELECTION.
  IF avanzar1 EQ abap_true AND avanzar2 EQ abap_true AND avanzar3 EQ abap_true AND avanzar4 EQ abap_true.
    PERFORM get_data CHANGING gv_confirm.
    PERFORM build_field_cat.
    PERFORM build_layout.
    IF gv_confirm EQ abap_true.
      PERFORM display_alv_list.
    ENDIF.
  ENDIF.
