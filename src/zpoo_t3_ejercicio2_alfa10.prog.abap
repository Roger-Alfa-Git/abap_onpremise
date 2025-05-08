*&---------------------------------------------------------------------*
*& Report ZPOO_T3_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t3_ejercicio2_alfa10.

CLASS sistema DEFINITION.
  PUBLIC SECTION.
    DATA: arquitectura TYPE string.

    METHODS: obtener_arq IMPORTING arquitectura TYPE string.

ENDCLASS.

CLASS linux DEFINITION INHERITING FROM sistema.



ENDCLASS.

CLASS sistema IMPLEMENTATION.

  METHOD obtener_arq.
    me->arquitectura = arquitectura.
    WRITE / me->arquitectura.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_linux TYPE REF TO linux.

  CREATE OBJECT gr_linux.

  gr_linux->obtener_arq( arquitectura = '64BITS' ).
