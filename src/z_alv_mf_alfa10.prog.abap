*&---------------------------------------------------------------------*
*& Report Z_ALV_MF_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_alv_mf_alfa10.

INCLUDE z_alv_mf_alfa10_top.
INCLUDE z_alv_mf_alfa10_sel.
INCLUDE z_alv_mf_alfa10_f01.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM build_field_cat.
  PERFORM build_layout.
  PERFORM add_event.

  CASE abap_true.
    WHEN p_list.
      PERFORM display_alv_list.
    WHEN p_grid.
      PERFORM display_alv_grid.
    WHEN p_hier.
      PERFORM display_alv_hier.
  ENDCASE.
