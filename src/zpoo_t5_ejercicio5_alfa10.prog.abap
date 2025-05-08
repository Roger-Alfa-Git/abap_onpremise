*&---------------------------------------------------------------------*
*& Report ZPOO_T5_EJERCICIO5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t5_ejercicio5_alfa10.

CLASS cl_pantalla DEFINITION.
  PUBLIC SECTION.
    DATA: tipo_pantalla TYPE string.
    METHODS: set_tipo_pantalla IMPORTING tipo_pantalla TYPE string.
ENDCLASS.

CLASS cl_telefono DEFINITION.
  PUBLIC SECTION.
    DATA: pantalla TYPE REF TO cl_pantalla.
    METHODS: constructor IMPORTING pantalla TYPE REF TO cl_pantalla.
ENDCLASS.

CLASS cl_pantalla IMPLEMENTATION.
  METHOD set_tipo_pantalla.
    me->tipo_pantalla = tipo_pantalla.
  ENDMETHOD.
ENDCLASS.

CLASS cl_telefono IMPLEMENTATION.
  METHOD constructor.
    me->pantalla = pantalla.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_pantalla TYPE REF TO cl_pantalla,
        gr_telefono TYPE REF TO cl_telefono.

  CREATE OBJECT: gr_pantalla.

  gr_pantalla->set_tipo_pantalla( tipo_pantalla = '8pul' ).

  CREATE OBJECT gr_telefono
    EXPORTING
      pantalla = gr_pantalla.

  WRITE: / gr_telefono->pantalla->tipo_pantalla.
