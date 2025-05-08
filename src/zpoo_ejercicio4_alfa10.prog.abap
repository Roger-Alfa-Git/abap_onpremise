*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio4_alfa10.

CLASS persona DEFINITION.

  PUBLIC SECTION.
    METHODS: valor1 IMPORTING i_valor TYPE i,
      valor2 EXPORTING e_valor TYPE i.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: edad TYPE i.

ENDCLASS.

CLASS persona IMPLEMENTATION.

  METHOD valor1.
    edad = i_valor.
  ENDMETHOD.

  METHOD valor2.
    e_valor = edad.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_persona TYPE REF TO persona,
        gv_edad    TYPE i.

  CREATE OBJECT gr_persona.

  gr_persona->valor1( i_valor = 23 ).

  gr_persona->valor2(
    IMPORTING
      e_valor = gv_edad
  ).

  WRITE: / gv_edad.
