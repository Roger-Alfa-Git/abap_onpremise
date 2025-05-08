*&---------------------------------------------------------------------*
*& Report ZPOO_GET_PERSIST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_get_persist_alfa10.

DATA: gr_actor      TYPE REF TO zca_persist_estud_alfa10,
      gr_estudiante TYPE REF TO zcl_persist_estud_alfa10,
      grx_exeption  TYPE REF TO cx_root.

gr_actor = zca_persist_estud_alfa10=>agent.

TRY.

    gr_estudiante = gr_actor->get_persistent( i_estudiante = sy-uname ).
    IF gr_estudiante IS BOUND.
      WRITE: / gr_estudiante->get_estudiante( ),
             / gr_estudiante->get_nombre( ),
             / gr_estudiante->get_fecha_nacimiento( ).
    ENDIF.
  CATCH cx_os_object_not_found. " Excepción de servicios de objeto
    WRITE: / grx_exeption->get_text( ).
ENDTRY.
