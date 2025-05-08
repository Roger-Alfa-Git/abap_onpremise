*&---------------------------------------------------------------------*
*& Report ZPOO_OBJ_MEMORIA_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_obj_memoria_alfa10.

DATA: gr_handler_area TYPE REF TO zcl_pedido_area_alfa10,
      gr_pedido       TYPE REF TO zcl_pedido_alfa10.
TRY.
    gr_handler_area = zcl_pedido_area_alfa10=>attach_for_write(
*                        client      =
*                        inst_name   = cl_shm_area=>default_instance
*                        attach_mode = cl_shm_area=>attach_mode_default
*                        wait_time   = 0
                      ).
  CATCH cx_shm_exclusive_lock_active.  " Instanz ist schon gesperrt
  CATCH cx_shm_version_limit_exceeded. " Keine weiteren Versionen verfügbar
  CATCH cx_shm_change_lock_active.     " Eine Schreibsperre ist schon aktiv
  CATCH cx_shm_parameter_error.        " Übergebener Parameter hat falschen Wert
  CATCH cx_shm_pending_lock_removed.   " Shared Objects: wartende Sperre wurde gelöscht
ENDTRY.

CREATE OBJECT gr_pedido AREA HANDLE gr_handler_area.

gr_pedido->set_fecha_creacion( fecha_creacion = sy-datum ).

gr_pedido->set_hora_pedido( hora_pedido = sy-uzeit ).

TRY.
    gr_handler_area->set_root( root = gr_pedido ).
  CATCH cx_shm_initial_reference. " Initiale Referenz übergeben
  CATCH cx_shm_wrong_handle.      " Falsches Handle
ENDTRY.

TRY.
    gr_handler_area->detach_commit( ).
  CATCH cx_shm_wrong_handle.
  CATCH cx_shm_already_detached.
  CATCH cx_shm_secondary_commit.
  CATCH cx_shm_event_execution_failed.
  CATCH cx_shm_completion_error.
ENDTRY.
WRITE: / 'Objeto en memoria compartida'.
