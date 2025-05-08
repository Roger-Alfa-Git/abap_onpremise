*&---------------------------------------------------------------------*
*& Report ZPOO_DEF_EVENTO_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_def_evento_alfa10.

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
      RAISE EVENT time_out EXPORTING hora = sy-uzeit.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
