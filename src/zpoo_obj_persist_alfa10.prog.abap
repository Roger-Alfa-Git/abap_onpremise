*&---------------------------------------------------------------------*
*& Report ZPOO_OBJ_PERSIST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_obj_persist_alfa10.

DATA: gr_actor      TYPE REF TO zca_persist_estud_alfa10,
      gr_estudiante TYPE REF TO zcl_persist_estud_alfa10,
      grx_exepcion  TYPE REF TO cx_root.

gr_actor = zca_persist_estud_alfa10=>agent.

TRY.
    gr_estudiante = gr_actor->create_persistent( i_estudiante = sy-uname ).
    gr_estudiante->set_nombre( i_nombre = 'ALFA10' ).
    gr_estudiante->set_fecha_nacimiento( i_fecha_nacimiento = '20000815' ).
  CATCH cx_os_object_existing INTO grx_exepcion. " Excepción de servicios de objeto
    WRITE: / grx_exepcion->get_text( ).
ENDTRY.

COMMIT WORK.

WRITE: / 'Datos persistidos en base de datos'.
