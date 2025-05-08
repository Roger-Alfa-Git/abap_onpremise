*&---------------------------------------------------------------------*
*& Report ZPOO_OBJ_TRANSIT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_obj_transit_alfa10.

DATA: gr_actor      TYPE REF TO zca_persist_estud_alfa10,
      gr_estudiante TYPE REF TO zcl_persist_estud_alfa10,
      grx_exeption  TYPE REF TO cx_root.

gr_actor = zca_persist_estud_alfa10=>agent.

TRY.
    gr_estudiante = gr_actor->create_transient( i_estudiante = 'ALFA10' ).
    gr_estudiante->set_nombre( i_nombre = 'ALFA10' ).
    gr_estudiante->set_fecha_nacimiento( i_fecha_nacimiento = '20000815' ).
  CATCH cx_os_object_existing INTO grx_exeption. " Excepción de servicios de objeto
    WRITE: / grx_exeption->get_text( ).
ENDTRY.

COMMIT WORK.

WRITE : / 'Programa Finalizada'.
TRY.
    gr_estudiante = gr_actor->get_transient( i_estudiante = 'ALFA10' ).
    WRITE: / gr_estudiante->get_estudiante( ),
           / gr_estudiante->get_nombre( ),
           / gr_estudiante->get_fecha_nacimiento( ).
  CATCH cx_os_object_not_found INTO grx_exeption. " Excepción de servicios de objeto
    grx_exeption->get_text( ).
ENDTRY.
