*&---------------------------------------------------------------------*
*& Report ZPOO_T3_EJERCICIO10_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t3_ejercicio10_alfa10.

CLASS socio DEFINITION.
  PUBLIC SECTION.
    METHODS: get_capital_empresa.
ENDCLASS.

CLASS empresa DEFINITION FRIENDS socio.
  PRIVATE SECTION.
    CLASS-DATA: capital TYPE i VALUE 500000.
ENDCLASS.

CLASS colaborador DEFINITION INHERITING FROM socio.
  PUBLIC SECTION.
    METHODS: obtener_capital_empresa.
ENDCLASS.

CLASS socio IMPLEMENTATION.
  METHOD get_capital_empresa.
    WRITE / empresa=>capital.
  ENDMETHOD.
ENDCLASS.

CLASS colaborador IMPLEMENTATION.
  METHOD obtener_capital_empresa.
    WRITE / empresa=>capital.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_socio       TYPE REF TO socio,
        gr_colaborador TYPE REF TO colaborador.

  CREATE OBJECT: gr_socio, gr_colaborador.

  gr_socio->get_capital_empresa( ).

  gr_colaborador->obtener_capital_empresa( ).
