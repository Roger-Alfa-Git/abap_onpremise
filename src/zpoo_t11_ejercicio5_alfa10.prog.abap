*&---------------------------------------------------------------------*
*& Report ZPOO_T11_EJERCICIO5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t11_ejercicio5_alfa10.

DATA: gr_area       TYPE REF TO zcl_cesta_comp_area_alfa10,
      gs_ekpo       TYPE ekpo.

TRY.

    gr_area = zcl_cesta_comp_area_alfa10=>attach_for_read(
*                client    =
*                inst_name = cl_shm_area=>default_instance
              ).
  CATCH cx_shm_inconsistent.          " Unterschiedliche Definitionen zwischen Program und Gebiet
  CATCH cx_shm_no_active_version.     " Keine aktive Version für ein Attach vorhanden
  CATCH cx_shm_read_lock_active.      " Anforderung einer 2. Lesesperre
  CATCH cx_shm_exclusive_lock_active. " Instanz ist schon gesperrt
  CATCH cx_shm_parameter_error.       " Falscher Parameter übergeben
  CATCH cx_shm_change_lock_active.    " Eine Änderungssperre ist schon aktiv
ENDTRY.

READ TABLE gr_area->root->doc_compras INTO gs_ekpo INDEX 1.

WRITE:  / gs_ekpo-ebeln,
        / gs_ekpo-ebelp.

TRY.
    gr_area->detach( ).
  CATCH cx_shm_wrong_handle.    "
  CATCH cx_shm_already_detached.    "
ENDTRY.
