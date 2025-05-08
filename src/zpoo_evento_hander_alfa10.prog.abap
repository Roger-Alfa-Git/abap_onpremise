*&---------------------------------------------------------------------*
*& Report ZPOO_EVENTO_HANDER_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_evento_hander_alfa10.


CLASS cl_temporizador DEFINITION.
  PUBLIC SECTION.
    EVENTS time_out EXPORTING VALUE(hora) TYPE sy-uzeit.
    METHODS: constrcutor,
      incrementar_contador,
      comprobar_limite.
    DATA: user TYPE uname.
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
  METHOD constrcutor.
    me->user = sy-uname.
  ENDMETHOD.
ENDCLASS.


CLASS cl_conexion DEFINITION.
  PUBLIC SECTION.
    METHODS: on_time_out FOR EVENT time_out OF cl_temporizador IMPORTING hora sender.
ENDCLASS.

CLASS cl_conexion IMPLEMENTATION.
  METHOD on_time_out.
    WRITE : / 'Usuario Desconectado ', hora ENVIRONMENT TIME FORMAT.

    "LogOut
    WRITE: sender->user.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_temporizador TYPE REF TO cl_temporizador,
        gr_conexion     TYPE REF TO cl_conexion.

  CREATE OBJECT: gr_temporizador,
                 gr_conexion.

  SET HANDLER gr_conexion->on_time_out FOR gr_temporizador.

  DO 10 TIMES.
    WAIT UP TO 1 SECONDS.
    gr_temporizador->incrementar_contador( ).
  ENDDO.
