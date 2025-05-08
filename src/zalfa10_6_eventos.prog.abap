*&---------------------------------------------------------------------*
*& Report ZALFA10_6_EVENTOS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalfa10_6_eventos.


CLASS cl_temporizador DEFINITION.

  PUBLIC SECTION.

    EVENTS time_out EXPORTING VALUE(hora) TYPE sy-uzeit.

    METHODS: incrementar_contador,
      comprobar_limite.

  PRIVATE SECTION.

    DATA contador TYPE i.

ENDCLASS.

CLASS cl_temporizador IMPLEMENTATION.

  METHOD incrementar_contador.

    ADD 1 TO me->contador.
    me->comprobar_limite( ).

  ENDMETHOD.

  METHOD comprobar_limite.

    IF me->contador GE 5.
      WRITE / 'Se levanta el evento'.
      RAISE EVENT time_out EXPORTING hora = sy-uzeit.
    ENDIF.

  ENDMETHOD.

ENDCLASS.


CLASS cl_conexion DEFINITION.

  PUBLIC SECTION.

    METHODS on_time_out FOR EVENT time_out OF cl_temporizador
      IMPORTING hora.

ENDCLASS.


CLASS cl_conexion IMPLEMENTATION.

  METHOD on_time_out.

    WRITE: / 'Usuario desconectado ', hora ENVIRONMENT TIME FORMAT.

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA: gr_temporizador TYPE REF TO cl_temporizador,
        gr_conexion     TYPE REF TO cl_conexion.

  CREATE OBJECT:  gr_temporizador,
                  gr_conexion.

  set HANDLER gr_conexion->on_time_out for gr_temporizador.
