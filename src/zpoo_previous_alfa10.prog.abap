*&---------------------------------------------------------------------*
*& Report ZPOO_PREVIOUS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_previous_alfa10.

CLASS LCX_exepcion DEFINITION INHERITING FROM cx_static_check.

ENDCLASS.

CLASS lcl_ejecutar DEFINITION.
  PUBLIC SECTION.
    METHODS: emitir_ex_autorizacion IMPORTING previous TYPE REF TO cx_root OPTIONAL RAISING zcx_autorizacion_alfa10,
      emitir_ex_permisos IMPORTING previous TYPE REF TO cx_root RAISING zcx_permisos_alfa10,
      emitir_ex_ejecucion IMPORTING previous TYPE REF TO cx_root RAISING lcx_exepcion.
ENDCLASS.

CLASS lcl_ejecutar IMPLEMENTATION.
  METHOD emitir_ex_autorizacion.
    RAISE EXCEPTION TYPE zcx_autorizacion_alfa10
      EXPORTING
*       textid   =
        previous = previous.
  ENDMETHOD.
  METHOD emitir_ex_permisos.
    RAISE EXCEPTION TYPE zcx_permisos_alfa10
      EXPORTING
*       textid   =
        previous = previous
*       msgv1    =
*       msgv2    =
*       msgv3    =
*       msgv4    =
      .
  ENDMETHOD.
  METHOD emitir_ex_ejecucion.
    RAISE EXCEPTION TYPE lcx_exepcion
      EXPORTING
*       textid   =
        previous = previous.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: go_ejecutar      TYPE REF TO lcl_ejecutar,
        gcx_autorizacion TYPE REF TO zcx_autorizacion_alfa10,
        gcx_permisos     TYPE REF TO zcx_permisos_alfa10,
        gcx_exepcion     TYPE REF TO lcx_exepcion.

  CREATE OBJECT: go_ejecutar.
  TRY.
      TRY.
          TRY.
              go_ejecutar->emitir_ex_autorizacion(  ).
            CATCH zcx_autorizacion_alfa10 INTO gcx_autorizacion. " Clase de Exepcion para las autorizaciones
              go_ejecutar->emitir_ex_permisos( previous = gcx_autorizacion ).
          ENDTRY.
        CATCH zcx_permisos_alfa10 INTO gcx_permisos. " Clase de exepcion con clase de mensajes
          go_ejecutar->emitir_ex_ejecucion( previous = gcx_permisos ).
      ENDTRY.
    CATCH lcx_exepcion INTO gcx_exepcion.
      WRITE: / gcx_exepcion->get_text( ).
  ENDTRY.
