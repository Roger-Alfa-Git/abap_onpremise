*&---------------------------------------------------------------------*
*& Report ZPOO_DEL_PERSIST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_del_persist_alfa10.

DATA: gr_actor     TYPE REF TO zca_persist_estud_alfa10,
      grx_exepcion TYPE REF TO cx_root.

gr_actor = zca_persist_estud_alfa10=>agent.

TRY.
    gr_actor->delete_persistent( i_estudiante = sy-uname ).
    COMMIT WORK.
    WRITE: / 'Se ha eliminado el estudiante: ',sy-uname.
  CATCH cx_os_object_not_existing INTO grx_exepcion. " Excepción de servicios de objeto
    WRITE: / grx_exepcion->get_text( ).
ENDTRY.
