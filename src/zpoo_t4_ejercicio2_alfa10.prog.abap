*&---------------------------------------------------------------------*
*& Report ZPOO_T4_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t4_ejercicio2_alfa10.

INTERFACE if_libro.
  METHODS: set_titulo.
ENDINTERFACE.

CLASS sociales DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_libro.
ENDCLASS.

CLASS sociales IMPLEMENTATION.
  METHOD if_libro~set_titulo.
    WRITE: / 'Metodo set_titulo obligado en sociales'.
  ENDMETHOD.
ENDCLASS.
