*&---------------------------------------------------------------------*
*& Report ZPOO_OBJETO_RECEP_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_objeto_recep_alfa10.

CLASS cl_temporizador DEFINITION.
  PUBLIC SECTION.
    EVENTS time_out EXPORTING VALUE(hora) TYPE sy-uzeit.
    METHODS: incrementar_contador,
      comprobar_limite.
  PRIVATE SECTION.
    DATA: contador TYPE i.
ENDCLASS.

CLASS cl_temporizador IMPLEMENTATION.
  METHOD incrementar_contador.
    ADD 1 TO me->contador.
    me->comprobar_limite( ).
  ENDMETHOD.
  METHOD comprobar_limite.
    IF me->contador GE 5.
      WRITE / 'Evento levantado'.
      RAISE EVENT time_out EXPORTING hora = sy-uzeit.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


CLASS cl_conexion DEFINITION.
  PUBLIC SECTION.
    METHODS: on_time_out FOR EVENT time_out OF cl_temporizador IMPORTING hora.
ENDCLASS.

CLASS cl_conexion IMPLEMENTATION.
  METHOD on_time_out.
    WRITE : / 'Usuario Desconectado ', hora ENVIRONMENT TIME FORMAT.

    "LogOut
  ENDMETHOD.
ENDCLASS.
