*&---------------------------------------------------------------------*
*& Report ZPOO_T3_EJERCICIO8_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t3_ejercicio8_alfa10.

CLASS persona DEFINITION.
  PUBLIC SECTION.
    DATA: nombre TYPE string.

    METHODS: establecer_nombre FINAL IMPORTING nombre TYPE string.
ENDCLASS.

CLASS persona IMPLEMENTATION.

  METHOD establecer_nombre.

  ENDMETHOD.

ENDCLASS.
