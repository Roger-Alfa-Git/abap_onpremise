*&---------------------------------------------------------------------*
*& Report ZPOO_T4_EJERCICIO5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t4_ejercicio5_alfa10.

INTERFACE if_plantilla.
  METHODS: set_header IMPORTING header TYPE string,
    set_body   IMPORTING body   TYPE string.
ENDINTERFACE.

CLASS office_doc DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_plantilla.

    ALIASES: set_header FOR if_plantilla~set_header,
             set_body   FOR if_plantilla~set_body.
ENDCLASS.

CLASS office_doc IMPLEMENTATION.
  METHOD set_body.

  ENDMETHOD.

  METHOD set_header.

  ENDMETHOD.
ENDCLASS.
