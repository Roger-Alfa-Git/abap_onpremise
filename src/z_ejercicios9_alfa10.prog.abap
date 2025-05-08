*&---------------------------------------------------------------------*
*& Report Z_EJERCICIOS9_ALFA10
*&---------------------------------------------------------------------*
*& Ejercicio 9.3
*&---------------------------------------------------------------------*
REPORT z_ejercicios9_alfa10.

INCLUDE z_ejercicios9_alfa10_top.

INCLUDE z_ejercicios9_alfa10_sel.

INCLUDE z_ejercicios9_alfa10_f01.

INITIALIZATION.

  PERFORM do_init.

AT SELECTION-SCREEN ON p_perio.

  PERFORM check_values.

START-OF-SELECTION.

  PERFORM execute_task TABLES gt_ib.

  CASE abap_true.
    WHEN p_create.
      PERFORM create_record USING gwa_inform_banco.
    WHEN p_read.
      PERFORM read_record USING gwa_inform_banco.
    WHEN p_update.
      PERFORM update_record TABLES gt_ib.
    WHEN p_delete.
      PERFORM delete_record TABLES gt_ib.
    WHEN p_modify.
      PERFORM modify_record USING gwa_inform_banco.
  ENDCASE.

  PERFORM list_all_records USING date_from date_to gt_ib.
