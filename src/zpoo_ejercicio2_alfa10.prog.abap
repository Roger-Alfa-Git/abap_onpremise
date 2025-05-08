*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio2_alfa10.

CLASS contrato DEFINITION.

  PUBLIC SECTION.
    DATA: tipo_cntr TYPE c LENGTH 2.

  PROTECTED SECTION.
    DATA: fecha_alta TYPE sydatum.
    METHODS: set_fecha_alta EXPORTING i_fecha_alta TYPE sydatum.

  PRIVATE SECTION.
    DATA: client TYPE xstring.

ENDCLASS.

CLASS contrato IMPLEMENTATION.

  METHOD set_fecha_alta.
    i_fecha_alta = fecha_alta.
  ENDMETHOD.

ENDCLASS.
