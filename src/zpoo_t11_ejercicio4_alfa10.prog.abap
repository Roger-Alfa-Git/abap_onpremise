*&---------------------------------------------------------------------*
*& Report ZPOO_T11_EJERCICIO4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t11_ejercicio4_alfa10.

DATA: gr_area          TYPE REF TO zcl_cesta_comp_area_alfa10,
      gr_cesta_compras TYPE REF TO zcl_cesta_compras_alfa10,
      gs_ekpo          TYPE ekpo.

TRY.

    gr_area = zcl_cesta_comp_area_alfa10=>attach_for_write(
*                client      =
*                inst_name   = cl_shm_area=>default_instance
*                attach_mode = cl_shm_area=>attach_mode_default
*                wait_time   = 0
              ).
  CATCH cx_shm_exclusive_lock_active.  " Instanz ist schon gesperrt
  CATCH cx_shm_version_limit_exceeded. " Keine weiteren Versionen verfügbar
  CATCH cx_shm_change_lock_active.     " Eine Schreibsperre ist schon aktiv
  CATCH cx_shm_parameter_error.        " Übergebener Parameter hat falschen Wert
  CATCH cx_shm_pending_lock_removed.   " Shared Objects: wartende Sperre wurde gelöscht
ENDTRY.

CREATE OBJECT gr_cesta_compras AREA HANDLE gr_area.

SELECT SINGLE * FROM ekpo
   INTO gs_ekpo
   WHERE ebeln EQ '4500000001'.

IF sy-subrc EQ 0.
  APPEND gs_ekpo TO gr_cesta_compras->doc_compras.
ENDIF.

TRY.
    gr_area->set_root( root = gr_cesta_compras ).
  CATCH cx_shm_initial_reference.    "
  CATCH cx_shm_wrong_handle.    "
ENDTRY. "

TRY.
    gr_area->detach_commit( ).
  CATCH cx_shm_wrong_handle.    "
  CATCH cx_shm_already_detached.    "
  CATCH cx_shm_secondary_commit.    "
  CATCH cx_shm_event_execution_failed.    "
  CATCH cx_shm_completion_error.    "
ENDTRY.

WRITE: / 'Objeto creado'.
